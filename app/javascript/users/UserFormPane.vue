<template>
  <form @submit.prevent="$emit('submit')">
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
  </form>
</template>

<script>
export default {
  props: {
    user: {},
    errors: "",
  },
};
</script>

<style scoped>
</style>
