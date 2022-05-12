<template>
<div class = "todo">
    <div class = "row">
    
    <h3>oh, so many things to do...</h3>

    <h5 v-if="getListLength(ToDoListItems)=='empty'" > Nothing here! Unbelievable </h5>
    
    <h6 v-if="getListLength(ToDoListItems)!='empty'">List of things ToDo</h6>

    <input v-model="listItem" placeholder="What to do?"/> <input v-model="dueDate" placeholder="Due Date"/>
    
    <button v-on:click="addItem(listItem, dueDate)" class="btn green lighten-5 black-text">Add Items</button>

    <p class="" v-for="(item, index) in ToDoListItems" :key="index"> 
    <span class ="z-depth-1"> 
        <del v-if="item.status=='done'">{{item.what_to_do}} | {{item.due_date}} </del>  
        <span v-else-if="item.status !='done'">{{item.what_to_do}} | {{item.due_date}}</span> &nbsp;
    </span>
        <button v-on:click="markItem(item.what_to_do)" class="btn yellow lighten-5 black-text">Mark</button>
        <button v-on:click="deleteItem([item.what_to_do])" class="btn red lighten-5 black-text">Delete</button>
     </p>
    </div>
</div> 
</template>

<script>
import axios from 'axios'
export default {
  name: 'ToDoList',
  props: {
  },
  methods:{
      getListLength(array){
          if(array.length < 1){
              return "empty"
          } else {
              return "populated"
          }
      },
      addItem(addItem, dueDate){
          if (addItem==""|| dueDate==""){
             alert("Error, both fields are required")
              return -1
          }
          let url = "http://35.192.217.159:5001/api/items"
          axios.post(url, {
              what_to_do: addItem,
              due_date: dueDate,
          })
          .then((response) => console.log(response))
          .finally(()=> this.reload())
          console.log(addItem, dueDate)
      },
      deleteItem(item){
          let url = "http://35.192.217.159:5001/api/items/" + item
          axios.delete(url)
          .then((response) => console.log(response))
          .finally(() => this.reload())
      },
      markItem(item){
          let url = "http://35.192.217.159:5001/api/items/" + item;
          axios.put(url)
          .then((response) => console.log(response))
          .finally(() => this.reload())
      },
      reload(){
          window.location.reload()
      }
  },
  data(){
      return{
            ToDoListItems: [],
            listItem: '',
            dueDate: '',
      }
  },
  mounted(){
      this.listItem = ''
      // To Return the todolist response
      axios.get('http://35.192.217.159:5001/api/items')
      .then((response) => {
          for (let i = 0; i < response['data'].length; i++){
                this.ToDoListItems.push(response['data'][i])
          }
      }) 
      console.log(this.ToDoListItems)
  }
}
</script>
