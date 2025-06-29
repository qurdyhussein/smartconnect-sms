const express = require("express");
const axios = require("axios");
const app = express();

app.use(express.json());

app.post("/sendSms", async (req, res) => {
  const { phone, message } = req.body;

  if (!phone || !message) {
    return res.status(400).json({ error: "Missing phone or message" });
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
          apiKey: process.env.AFRICASTALKING_API_KEY,
          "Content-Type": "application/x-www-form-urlencoded",
        },
      }
    );

    return res.status(200).json(response.data);
  } catch (error) {
    console.error("SMS Error:", error.response?.data || error.message);
    return res.status(500).json({
      error: "Failed to send SMS",
      details: error.response?.data || error.message,
    });
  }
});

// 🔥 Muhimu kwa Render
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`✅ SMS service running on port ${PORT}`);
});