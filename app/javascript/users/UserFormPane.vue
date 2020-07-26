<template>
  <b-container fluid>
    <form @submit.prevent="$emit('submit')">
      <div v-if="errors.length != 0">
        <ul v-for="e in errors" :key="e">
          <li>
            <font color="red">{{ e }}</font>
          </li>
        </ul>
      </div>
      <b-row class="my-1">
        <b-col sm="3">
          <label for="input-none">名前:</label>
        </b-col>
        <b-col sm="9">
          <b-form-input v-model="user.name" id="input-none" :state="null"></b-form-input>
        </b-col>
      </b-row>

      <b-row class="my-1">
        <b-col sm="3">
          <label for="input-none">年齢:</label>
        </b-col>
        <b-col sm="9">
          <b-form-input v-model="user.age" id="input-none" number="true" :state="null"></b-form-input>
        </b-col>
      </b-row>

      <b-row class="my-1">
        <b-col sm="3">
          <label for="input-none">性別:</label>
        </b-col>
        <b-col sm="9">
          <b-form-select v-model="user.gender" :options="genders"></b-form-select>
        </b-col>
      </b-row>

      <b-row class="my-1">
        <b-col sm="3">
          <label for="input-none">備考:</label>
        </b-col>
        <b-col sm="9">
          <b-form-input v-model="user.note" id="input-none" :state="null"></b-form-input>
        </b-col>
      </b-row>

      <div class="text-center">
        <b-button variant="success" type="submit">Commit</b-button>
      </div>
    </form>
  </b-container>
</template>

<script>
export default {
  props: {
    user: {},
    errors: "",
  },
  data() {
    return {
      selected: null,
      genders: [
        { value: "男", text: "男" },
        { value: "女", text: "女" },
      ],
    };
  },
};
</script>

<style scoped>
</style>
