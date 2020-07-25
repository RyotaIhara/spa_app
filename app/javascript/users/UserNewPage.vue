<template>
  <user-form-pane :errors="errors" :user="user" @submit="createUser"></user-form-pane>
</template>

<script>
import axios from "axios";

import UserFormPane from "users/UserFormPane.vue";

export default {
  components: {
    UserFormPane,
  },
  data: function () {
    return {
      user: {
        name: "",
        age: "",
        gender: "",
        note: "",
      },
      errors: "",
    };
  },
  methods: {
    createUser: function () {
      axios
        .post("/api/v1/users", this.user)
        .then((response) => {
          let e = response.data;
          this.$emit("created");
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
