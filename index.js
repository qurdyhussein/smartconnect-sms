const functions = require("firebase-functions");
const axios = require("axios");

exports.sendSms = functions.https.onRequest(async (req, res) => {
  const { phone, message } = req.body;

  if (!phone || !message) {
    return res.status(400).send("Missing phone or message");
  }

  try {
    const response = await axios.post(
      "https://api.africastalking.com/version1/messaging",
      new URLSearchParams({
        username: "sandbox", // badilisha kama uko live
        to: phone,
        message: message,
      }),
      {
        headers: {
          apiKey: "atsk_3940de98e4541289ec77659f2b5a6bcb05cafe1393b94e81c88fdad02c6e1e366da1a219", // badilisha na yako
          "Content-Type": "application/x-www-form-urlencoded",
        },
      }
    );

    return res.status(200).send(response.data);
  } catch (error) {
    console.error("SMS Error:", error.response && error.response.data ? error.response.data : error.message);
    return res.status(500).send("Failed to send SMS");
  }
});