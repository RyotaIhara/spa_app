<template>
  <div class="container">
    <router-view></router-view>
  </div>
</template>

<script>
import Vue from "vue";
import VueRouter from "vue-router";

import UserIndexPage from "./users/UserIndexPage.vue";
import UserNewPage from "./users/UserNewPage.vue";
import UserEditPage from "./users/UserEditPage.vue";

const router = new VueRouter({
  routes: [
    {
      path: "/",
      name: "UserIndexPage",
      component: UserIndexPage,
    },
    {
      path: "/users/new",
      name: "UserNewPage",
      component: UserNewPage,
    },
    {
      path: "/users/:id(\\d+)/edit",
      name: "UserEditPage",
      component: UserEditPage,
    },
  ],
});

// ref. https://jp.vuejs.org/v2/guide/plugins.html#%E3%83%97%E3%83%A9%E3%82%B0%E3%82%A4%E3%83%B3%E3%81%AE%E4%BD%BF%E7%94%A8
Vue.use(VueRouter);

export default {
  router,
};
</script>

<style scoped>
</style>
