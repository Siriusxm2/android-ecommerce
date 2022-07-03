const functions = require("firebase-functions");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const stripe = require("stripe")(functions.config().stripe.testkey);

exports.stripePaymentIntentRequest = functions.https.onRequest(
  async (req, res) => {
    try {
      let customerId;

      const customerList = await stripe.customers.list({
        email: req.body.email,
        limit: 1,
      });

      if (customerList.data.length !== 0) {
        customerId = customerList.data[0].id;
      } else {
        const customer = await stripe.customers.create({
          address: {
            city: "Varna",
            country: "BG",
            line1: req.body.address,
            postal_code: "9000",
          },
          email: req.body.email,
          name: req.body.name,
          phone: req.body.phone,
        });
        customerId = customer.data.id;
      }
      const ephemeralKey = await stripe.ephemeralKeys.create(
        { customer: customerId },
        { apiVersion: "2020-08-27" }
      );

      const paymentIntent = await stripe.paymentIntents.create({
        amount: parseInt(req.body.amount),
        currency: "bgn",
        customer: customerId,
      });

      res.status(200).send({
        paymentIntent: paymentIntent.client_secret,
        ephemeralKey: ephemeralKey.secret,
        customer: customerId,
        success: true,
      });
    } catch (e) {
      res.status(404).send({ success: false, error: e.message });
    }
  }
);
