<template>
  <div>
    <!-- -----------------------------------------------
          Start Header
    ----------------------------------------------- -->
    <v-app-bar app absolute class="app-header" flat elevate-on-scroll>
      <v-container class="py-0 fill-height">
        <!-- Logo -->

        <v-spacer></v-spacer>
        <!-- <v-btn class="d-block d-md-none" text @click="toggleClass()">
          <v-app-bar-nav-icon class="white--text" />
        </v-btn> -->
        <!-- Desktop view Navigation -->
        <div
          class="navigation d-inline-flex"
        >
          <ul class="navbar-nav">
            <li class="nav-item mr-4">
              <v-btn
                color="#FFB169"
                dark
                @click="dialog_edit = true"
              >
                Criar artigo
              </v-btn>
            </li>
            <li class="nav-item mr-4">
              <v-menu offset-y>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    color="#FFB169"
                    dark
                    v-bind="attrs"
                    v-on="on"
                  >
                    Filtrar
                  </v-btn>
                </template>
                <v-list>
                  <v-list-item>
                    <v-btn text @click="$emit('filterByOldest')" style="width: 100%">Mais antigas</v-btn>
                  </v-list-item>
                  <v-list-item>
                    <v-btn text @click="$emit('filterByNewest')" style="width: 100%">Mais novas</v-btn>
                  </v-list-item>
                </v-list>
              </v-menu>
            </li>
            <li class="nav-item pt-15">
              <div class="d-inline-flex">
                <v-text-field
                  placeholder="Buscar"
                  solo
                  v-model="search"
                ></v-text-field>
                <v-btn
                  @click="$emit('filterBySearch', search)"
                  style="position: relative; top: 0;right: 45px;"
                  icon
                  tile
                  color="#FFB169"
                  dark
                ><v-icon>mdi-magnify</v-icon>
                </v-btn>
              </div>
            </li>
          </ul>
        </div>
        <article-dialog :dialog_edit="dialog_edit" :article="article" is_component_used_in_create @reloadArticles="reloadArticles"></article-dialog>
      </v-container>
    </v-app-bar>
    <!-- -----------------------------------------------
          End Header
    ----------------------------------------------- -->
  </div>
</template>

<script>
export default {
  name: "Header",

  components: {
    Logo: () => import("@/layouts/sections/Logo"),
    ArticleDialog: () => import("@/components/articles/ArticleDialog")
  },
  data() {
    return {
      isActive: false,
      search: '',
      dialog_edit: false,
      article: {},
    };
  },
  methods: {
    toggleClass: function(event) {
      this.isActive = !this.isActive;
    },
    reloadArticles(){
      this.dialog_edit = false
    }
  }
};
</script>
