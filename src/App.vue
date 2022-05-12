<template>
<!--Icon Logo-->
  <span class="material-icons md-100" >checklist_rtl</span>
  <ToDoList/>
</template>

<script>
import ToDoList from './components/ToDoList.vue'

export default {
  name: 'App',
  components: {
    ToDoList
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c5050;
  margin-top: 60px;
}
.material-icons.md-100 { font-size: 100px; }
</style>
