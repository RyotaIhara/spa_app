<template>
  <user-form-pane :errors="errors" :user="user" @submit="updateUser"></user-form-pane>
</template>

<script>
import axios from "axios";

import UserFormPane from "users/UserFormPane.vue";

export default {
  props: {
    editTarget: Number,
  },
  components: {
    UserFormPane,
  },
  data: function () {
    return {
      user: {},
      errors: "",
    };
  },
  mounted() {
    axios
      .get(`/api/v1/users/${this.editTarget}.json`)
      .then((response) => (this.user = response.data));
  },
  methods: {
    updateUser: function () {
      axios
        .patch(`/api/v1/users/${this.editTarget}`, this.user)
        .then((response) => {
          console.log("メソッドが動いた");
          let e = response.data;
          this.$emit("edited");
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
  },
};
</script>

<style scoped>
</style>
