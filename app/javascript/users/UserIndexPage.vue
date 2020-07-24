<template>
  <div id="app">
    <div>
      <router-link :to="{ name: 'UserNewPage' }">新規作成</router-link>
    </div>
    <table class="table">
      <tbody>
        <tr>
          <th>ユーザー名</th>
          <th>年齢</th>
          <th>性別</th>
          <th>備考</th>
        </tr>
        <tr v-for="u in users" :key="u.id">
          <td>
            <router-link :to="{ name: 'UserEditPage', params: { id: u.id } }">{{ u.name }}</router-link>
          </td>
          <td>{{ u.age }}</td>
          <td>{{ u.gender }}</td>
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
