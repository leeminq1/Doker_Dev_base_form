const express = require("express");
const path = require("path");

const app = express();
const PORT = process.env.PORT || 8000;

// Vue 빌드된 정적 파일 서빙
app.use(express.static(path.join(__dirname, "dist")));

app.get("*", (req, res) => {
    res.sendFile(path.join(__dirname, "dist", "index.html"));
});

app.listen(PORT, () => {
    console.log(`🚀 Vue app is running at http://localhost:${PORT}`);
});
