const { defineConfig } = require('@vue/cli-service');

module.exports = defineConfig({
  transpileDependencies: true,
  devServer: {
    host: process.env.HOST || "localhost", // .env에서 HOST 가져오기
    port: process.env.PORT || 8000, // .env에서 PORT 가져오기
  }
});