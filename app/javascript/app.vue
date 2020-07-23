<template>
  <div id="app">
    <table>
      <tbody>
        <tr>
          <th>ID</th>
          <th>ユーザー名</th>
          <th>年齢</th>
          <th>性別</th>
          <th>備考</th>
        </tr>
        <tr v-for="u in users" :key="u.id">
          <td>{{ u.id }}</td>
          <td>{{ u.name }}</td>
          <td>{{ u.age }}</td>
          <td v-if="u.gender == true">男</td>
          <td v-else>女</td>
          <td>{{ u.note }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data: function () {
    return {
      users: [],
    };
  },
  mounted() {
    axios
      .get("/api/v1/users.json")
      .then((response) => (this.users = response.data));
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
