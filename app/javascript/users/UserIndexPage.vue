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
          <th>操作</th>
        </tr>
        <tr v-for="u in users" :key="u.id">
          <td>
            <router-link :to="{ name: 'UserEditPage', params: { id: u.id } }">{{ u.name }}</router-link>
          </td>
          <td>{{ u.age }}</td>
          <td>{{ u.gender }}</td>
          <td>{{ u.note }}</td>
          <td>
            <button @click="deleteTarget = u.id; showModal = true">Delete</button>
          </td>
        </tr>
      </tbody>
    </table>
    <modal v-if="showModal" @cancel="showModal = false" @ok="deleteUser(); showModal = false;">
      <div slot="body">Are you sure?</div>
    </modal>
  </div>
</template>

<script>
import axios from "axios";

import Modal from "shared/Modal.vue";

export default {
  components: {
    Modal,
  },
  data: function () {
    return {
      users: [],
      showModal: false,
      deleteTarget: -1,
      errors: "",
    };
  },
  mounted() {
    this.updateUsers();
  },
  methods: {
    deleteUser: function () {
      if (this.deleteTarget <= 0) {
        console.warn("deleteTarget should be grater than zero.");
        return;
      }

      axios
        .delete(`/api/v1/users/${this.deleteTarget}`)
        .then((response) => {
          this.deleteTarget = -1;
          this.updateUsers();
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    updateUsers: function () {
      axios
        .get("/api/v1/users.json")
        .then((response) => (this.users = response.data));
    },
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
