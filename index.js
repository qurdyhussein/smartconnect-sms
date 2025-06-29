const express = require("express");
const axios = require("axios");
const app = express();

app.use(express.json());

app.post("/sendSms", async (req, res) => {
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
          apiKey: process.env.AFRICASTALKING_API_KEY, // tumia env variable
          "Content-Type": "application/x-www-form-urlencoded",
        },
      }
    );

    return res.status(200).send(response.data);
  } catch (error) {
    console.error("SMS Error:", error.response?.data || error.message);
    return res.status(500).send("Failed to send SMS");
  }
});

// 🔥 Hii ndiyo muhimu kwa Render
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`SMS service running on port ${PORT}`);
});