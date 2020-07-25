<template>
  <div id="app">
    <div>
      <b-button v-b-modal.new-user>新規作成</b-button>
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
          <td>{{ u.name }}</td>
          <td>{{ u.age }}</td>
          <td>{{ u.gender }}</td>
          <td>{{ u.note }}</td>
          <td>
            <b-button v-b-modal.edit-user class="btn-success" @click="editTarget = u.id">編集</b-button>
            <b-button v-b-modal.delete-user class="btn-danger" @click="deleteTarget = u.id">削除</b-button>
          </td>
        </tr>
      </tbody>
    </table>
    <!-- 新規作成モーダル -->
    <b-modal id="new-user" title="ユーザー追加" hide-footer>
      <div>
        <user-new-page v-on:created="closeNewModal"></user-new-page>
      </div>
    </b-modal>
    <!-- 編集モーダル -->
    <b-modal id="edit-user" title="ユーザー編集" hide-footer>
      <div>
        <user-edit-page :editTarget="editTarget" v-on:edited="closeEditModal"></user-edit-page>
      </div>
    </b-modal>
    <!-- 削除確認モーダル -->
    <b-modal id="delete-user">
      <div>
        <b class="lead">削除してもよろしいですか？</b>
      </div>
      <template v-slot:modal-footer>
        <div class="w-100 text-right">
          <b-button
            variant="primary"
            @click="deleteUser(); show=$bvModal.hide('delete-user')"
            class="text-right"
          >OK</b-button>
          <b-button
            variant="primary"
            @click="show=$bvModal.hide('delete-user')"
            class="text-right btn-danger"
          >cancel</b-button>
        </div>
      </template>
    </b-modal>
  </div>
</template>

<script>
import axios from "axios";

import Modal from "shared/Modal.vue";
import UserNewPage from "users/UserNewPage.vue";
import UserEditPage from "users/UserEditPage.vue";

export default {
  components: {
    Modal,
    UserNewPage,
    UserEditPage,
  },
  data: function () {
    return {
      users: [],
      showDeleteModal: false,
      showCreateModal: false,
      showEditModal: false,
      editTarget: -1,
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
    closeNewModal: function () {
      this.$bvModal.hide("new-user");
      this.updateUsers();
    },
    closeEditModal: function () {
      this.$bvModal.hide("edit-user");
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
