<template>
  <div id="app">
    <div>
      <router-link :to="{ name: 'UserNewPage' }">新規作成</router-link>
      <button @click="showCreateModal = true">新規作成２</button>
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
            <button @click="deleteTarget = u.id; showDeleteModal = true">Delete</button>
          </td>
        </tr>
      </tbody>
    </table>
    <!-- 削除確認モーダル -->
    <modal
      v-if="showDeleteModal"
      @cancel="showDeleteModal = false"
      @ok="deleteUser(); showDeleteModal = false;"
    >
      <div slot="body">Are you sure?</div>
    </modal>
    <!-- 新規作成フォームモーダル -->
    <user-new-page v-if="showCreateModal" v-on:created="closeModal" v-on:cancel="closeModal"></user-new-page>
  </div>
</template>

<script>
import axios from "axios";

import Modal from "shared/Modal.vue";
import UserNewPage from "users/UserNewPageModal.vue";

export default {
  components: {
    Modal,
    UserNewPage,
  },
  data: function () {
    return {
      users: [],
      showDeleteModal: false,
      showCreateModal: false,
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
    closeModal: function () {
      this.showCreateModal = false;
      this.updateUsers();
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
