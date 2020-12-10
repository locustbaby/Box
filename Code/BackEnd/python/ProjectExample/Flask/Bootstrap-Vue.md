#### Bootstrap-Vue

##### templates/index.html

```html
 <!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <!-- Add this to <head> -->

  <!-- Load required Bootstrap and BootstrapVue CSS -->
  <link type="text/css" rel="stylesheet" href="//unpkg.com/bootstrap/dist/css/bootstrap.min.css" />
  <link type="text/css" rel="stylesheet" href="//unpkg.com/bootstrap-vue@latest/dist/bootstrap-vue.min.css" />
</head>
<body>
 <div id="app">
  <div>
   <h2>Example heading <b-badge>New</b-badge></h2>
  </div>
   <template>
    <b-container fluid>
    <!-- User Interface controls -->
    <b-row>
      <b-col md="6" class="my-1">
        <b-form-group label-cols-sm="3" label="Filter" class="mb-0">
          <b-input-group>
            <b-form-input v-model="filter" placeholder="Type to Search"></b-form-input>
            <b-input-group-append>
              <b-button :disabled="!filter" @click="filter = ''">Clear</b-button>
            </b-input-group-append>
          </b-input-group>
        </b-form-group>
      </b-col>

      <b-col md="6" class="my-1">
        <b-form-group label-cols-sm="3" label="Sort" class="mb-0">
          <b-input-group>
            <b-form-select v-model="sortBy" :options="sortOptions">
              <option slot="first" :value="null">-- none --</option>
            </b-form-select>
            <b-form-select v-model="sortDesc" :disabled="!sortBy" slot="append">
              <option :value="false">Asc</option> <option :value="true">Desc</option>
            </b-form-select>
          </b-input-group>
        </b-form-group>
      </b-col>

      <b-col md="6" class="my-1">
        <b-form-group label-cols-sm="3" label="Sort direction" class="mb-0">
          <b-input-group>
            <b-form-select v-model="sortDirection" slot="append">
              <option value="asc">Asc</option> <option value="desc">Desc</option>
              <option value="last">Last</option>
            </b-form-select>
          </b-input-group>
        </b-form-group>
      </b-col>

      <b-col md="6" class="my-1">
        <b-form-group label-cols-sm="3" label="Per page" class="mb-0">
          <b-form-select v-model="perPage" :options="pageOptions"></b-form-select>
        </b-form-group>
      </b-col>
    </b-row>

    <!-- Main table element -->
    <b-table
      show-empty
      stacked="md"
      :items="items"
      :fields="fields"
      :current-page="currentPage"
      :per-page="perPage"
      :filter="filter"
      :sort-by.sync="sortBy"
      :sort-desc.sync="sortDesc"
      :sort-direction="sortDirection"
      @filtered="onFiltered"
    >
      <template slot="name" slot-scope="row">
        {{ row.value.first }} {{ row.value.last }}
      </template>

      <template slot="isActive" slot-scope="row">
        {{ row.value ? 'Yes :)' : 'No :(' }}
      </template>

      <template slot="actions" slot-scope="row">
        <b-button size="sm" @click="info(row.item, row.index, $event.target)" class="mr-1">
          Info modal
        </b-button>
        <b-button size="sm" @click="row.toggleDetails">
          {{ row.detailsShowing ? 'Hide' : 'Show' }} Details
        </b-button>
      </template>

      <template slot="row-details" slot-scope="row">
        <b-card>
          <ul>
            <li v-for="(value, key) in row.item" :key="key">{{ key }}: {{ value }}</li>
          </ul>
        </b-card>
      </template>
    </b-table>

    <b-row>
      <b-col md="6" class="my-1">
        <b-pagination
          v-model="currentPage"
          :total-rows="totalRows"
          :per-page="perPage"
          class="my-0"
        ></b-pagination>
      </b-col>
    </b-row>

    <!-- Info modal -->
    <b-modal :id="infoModal.id" :title="infoModal.title" ok-only @hide="resetInfoModal">
      <pre>{{ infoModal.content }}</pre>
    </b-modal>
  </b-container>
  </template>
 </div>
</body>
<!-- Load polyfills to support older browsers -->
<script src="//polyfill.io/v3/polyfill.min.js?features=es2015%2CMutationObserver" crossorigin="anonymous"></script>

<!-- Load Vue followed by BootstrapVue -->
<script src="//unpkg.com/vue@latest/dist/vue.min.js"></script>
<script src="//unpkg.com/bootstrap-vue@latest/dist/bootstrap-vue.min.js"></script>
<script src="//unpkg.com/axios/dist/axios.min.js"></script>
<script src="../static/app.js"></script>
</html>
```

##### templates/input.html

```html
 <!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <!-- Add this to <head> -->

  <!-- Load required Bootstrap and BootstrapVue CSS -->
  <link type="text/css" rel="stylesheet" href="//unpkg.com/bootstrap/dist/css/bootstrap.min.css" />
  <link type="text/css" rel="stylesheet" href="//unpkg.com/bootstrap-vue@latest/dist/bootstrap-vue.min.css" />
</head>
<body>
 <div id="input">
  <div>
   <h2>Example heading <b-badge>New</b-badge></h2>
  </div>
  <div>
    <template>
  <div>
    <b-form-textarea
      id="textarea"
      v-model="text"
      placeholder="Enter something..."
      rows="3"
      max-rows="6"
    ></b-form-textarea>

    <pre class="mt-3 mb-0">{{ text }}</pre>
    </div>
    </template>
  <b-button v-on:click="input" type="submit">Button</b-button>
  </div>
 </div>
</body>
<!-- Load polyfills to support older browsers -->
<script src="//polyfill.io/v3/polyfill.min.js?features=es2015%2CMutationObserver" crossorigin="anonymous"></script>

<!-- Load Vue followed by BootstrapVue -->
<script src="//unpkg.com/vue@latest/dist/vue.min.js"></script>
<script src="//unpkg.com/bootstrap-vue@latest/dist/bootstrap-vue.min.js"></script>
<script src="//unpkg.com/axios/dist/axios.min.js"></script>
<script src="../static/app.js"></script>
<script>
var input = new Vue({
    el: '#input',
    data: {
            text: ''
        },
    methods: {
        input: function () {
            axios.post('/input', { user : this.text })
            .then(function(response) {
                console.log(response);
                alert(response.data.name);
                })
            }
        }
    })
</script>
</html>
[work@yq01-sqep-liuchuanfeng Flask]$ cat templates/input.html 
 <!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <!-- Add this to <head> -->

  <!-- Load required Bootstrap and BootstrapVue CSS -->
  <link type="text/css" rel="stylesheet" href="//unpkg.com/bootstrap/dist/css/bootstrap.min.css" />
  <link type="text/css" rel="stylesheet" href="//unpkg.com/bootstrap-vue@latest/dist/bootstrap-vue.min.css" />
</head>
<body>
 <div id="input">
  <div>
   <h2>Example heading <b-badge>New</b-badge></h2>
  </div>
  <div>
    <template>
  <div>
    <b-form-textarea
      id="textarea"
      v-model="text"
      placeholder="Enter something..."
      rows="3"
      max-rows="6"
    ></b-form-textarea>

    <pre class="mt-3 mb-0">{{ text }}</pre>
    </div>
    </template>
  <b-button v-on:click="input" type="submit">Button</b-button>
  </div>
 </div>
</body>
<!-- Load polyfills to support older browsers -->
<script src="//polyfill.io/v3/polyfill.min.js?features=es2015%2CMutationObserver" crossorigin="anonymous"></script>

<!-- Load Vue followed by BootstrapVue -->
<script src="//unpkg.com/vue@latest/dist/vue.min.js"></script>
<script src="//unpkg.com/bootstrap-vue@latest/dist/bootstrap-vue.min.js"></script>
<script src="//unpkg.com/axios/dist/axios.min.js"></script>
<script src="../static/app.js"></script>
<script>
var input = new Vue({
    el: '#input',
    data: {
            text: ''
        },
    methods: {
        input: function () {
            axios.post('/input', { user : this.text })
            .then(function(response) {
                console.log(response);
                alert(response.data.name);
                })
            }
        }
    })
</script>
</html>
```

##### static/app.js

```javascript
var app = new Vue({
              el: '#app',
              data() {
      return {
        items: [
        {isActive:false}
        ],
        fields: [
          { key: 'name', label: 'Person Full name', sortable: true, sortDirection: 'desc' },
          { key: 'age', label: 'Person age', sortable: true, class: 'text-center' },
          { key: 'isActive', label: 'is Active' },
          { key: 'actions', label: 'Actions' }
        ],
        totalRows: 1,
        currentPage: 1,
        perPage: 20,
        pageOptions: [20, 40, 100],
        sortBy: null,
        sortDesc: false,
        sortDirection: 'asc',
        filter: null,
        infoModal: {
          id: 'info-modal',
          title: '',
          content: ''
        }
      }
    },
    created: function () {
        axios.post('/input', { user : 'sss' })
        .then(function (response) {
            console.log(response.data.age)
            this.items = response.data.age // this -> function
            console.log(this.items)
            }.bind(this)) // this -> app
    },
    computed: {
      sortOptions() {
        // Create an options list from our fields
        return this.fields
          .filter(f => f.sortable)
          .map(f => {
            return { text: f.label, value: f.key }
          })
      }
    },
    mounted() {
      // Set the initial number of items
      this.totalRows = this.items.length
    },
    methods: {
      info(item, index, button) {
        this.infoModal.title = `Row index: ${index}`
        this.infoModal.content = JSON.stringify(item, null, 2)
        this.$root.$emit('bv::show::modal', this.infoModal.id, button)
      },
      resetInfoModal() {
        this.infoModal.title = ''
        this.infoModal.content = ''
      },
      onFiltered(filteredItems) {
        // Trigger pagination to update the number of buttons/pages due to filtering
        this.totalRows = filteredItems.length
        this.currentPage = 1
      }
    }
});
```

##### filter with header

```javascript
new Vue({
  el: '#app',
  data: {
    filters: {
      id: '',
      issuedBy: '',
      issuedTo: ''
    },
    items: [{id:1234,issuedBy:'Operator',issuedTo:'abcd-efgh'},{id:5678,issuedBy:'User',issuedTo:'ijkl-mnop'}]
  },
  computed: {
    filtered () {
      const filtered = this.items.filter(item => {
        return Object.keys(this.filters).every(key =>
            String(item[key]).includes(this.filters[key]))
      })
      return filtered.length > 0 ? filtered : [{
        id: '',
        issuedBy: '',
        issuedTo: ''
      }]
    }
  }
})
```

```html
<link type="text/css" rel="stylesheet" href="//unpkg.com/bootstrap/dist/css/bootstrap.min.css"/><link type="text/css" rel="stylesheet" href="//unpkg.com/bootstrap-vue@latest/dist/bootstrap-vue.css"/><script src="https://cdn.jsdelivr.net/npm/vue@2.5.17/dist/vue.min.js"></script><script src="//unpkg.com/babel-polyfill@latest/dist/polyfill.min.js"></script><script src="//unpkg.com/bootstrap-vue@latest/dist/bootstrap-vue.js"></script>

<div id="app">
<b-table striped show-empty :items="filtered">
  <template slot="top-row" slot-scope="{ fields }">
    <td v-for="field in fields" :key="field.key">
      <input v-model="filters[field.key]" :placeholder="field.label">
    </td>
  </template>
</b-table>
</div>
```

