<template>
  <div id="app">
    <h1>Vue + FastAPI 연동 예제</h1>
    <h1>Vue + FastAPI 연동 예제 1213</h1>
    <button @click="fetchData">FastAPI에서 데이터 가져오기</button>
    <p v-if="data">{{ data }}</p>
  </div>
</template>

<script>
export default {
  data() {
    return {
      data: null
    };
  },
  methods: {
    async fetchData() {
      try {
        const response = await fetch("http://localhost:8080/api/data"); // FastAPI의 API 엔드포인트
        const result = await response.json();
        this.data = result.data;
      } catch (error) {
        console.error("API 요청 실패:", error);
      }
    }
  }
};
</script>

<style>
#app {
  font-family: Arial, sans-serif;
  text-align: center;
  margin-top: 50px;
}
</style>
