<template>
  <transition name="modal">
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">
          <div class="modal-header">
            <slot name="header"></slot>
          </div>

          <div class="modal-body">
            <slot name="body">
              <form @submit.prevent="createUser">
                <div v-if="errors.length != 0">
                  <ul v-for="e in errors" :key="e">
                    <li>
                      <font color="red">{{ e }}</font>
                    </li>
                  </ul>
                </div>
                <div>
                  <label>名前</label>
                  <input v-model="user.name" type="text" />
                </div>
                <div>
                  <label>年齢</label>
                  <input v-model="user.age" type="number" />
                </div>
                <div>
                  <label>性別</label>
                  <select v-model="user.gender">
                    <option>男</option>
                    <option>女</option>
                  </select>
                </div>
                <div>
                  <label>備考</label>
                  <input v-model="user.note" type="text" />
                </div>
                <button type="submit">Commit</button>
                <button type="button" class="modal-default-button" @click="$emit('cancel')">Cancel</button>
              </form>
            </slot>
          </div>

          <div class="modal-footer">
            <slot name="footer"></slot>
          </div>
        </div>
      </div>
    </div>
  </transition>
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
.modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: table;
  transition: opacity 0.3s ease;
}

.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}

.modal-container {
  width: 300px;
  margin: 0px auto;
  padding: 20px 30px;
  background-color: #fff;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
  transition: all 0.3s ease;
  font-family: Helvetica, Arial, sans-serif;
}

.modal-header h3 {
  margin-top: 0;
  color: #42b983;
}

.modal-body {
  margin: 20px 0;
}

.modal-default-button {
  float: right;
}

/*
 * The following styles are auto-applied to elements with
 * transition="modal" when their visibility is toggled
 * by Vue.js.
 *
 * You can easily play with the modal transition by editing
 * these styles.
 */

.modal-enter {
  opacity: 0;
}

.modal-leave-active {
  opacity: 0;
}

.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}
</style>
