<template>
  <div>
    <div class="banner1-component" :style="'background-color: '+background_color+';'">
      <v-container>
        <v-row justify="center">
          <v-col v-if="image_side == 'left'" cols="12" md="5" lg="5">
            <v-img
              :src="article.imageUrl"
              alt="banner"
              style="max-height: 350px;"
            />
          </v-col>
          <v-col cols="12" md="7" lg="6" class="d-flex align-center">
            <div :class="image_side == 'left' ? 'text-center text-md-right' : 'text-center text-md-left'">
              <v-chip small :color="background_color == '#302E53' ? '#FFB169' : '#302E53'" text-color="white">
                {{article.newsSite}}
              </v-chip>
              <h2
                class="
                  font-weight-bold
                  text-uppercase
                  white--text
                "
              >
              {{article.title}}
              </h2>
              <span style="color: white;">{{article_data}}</span>
              <p class="white--text op-8 font-weight-regular">
                {{article.summary}}
              </p>
              <div class="pt-2">
                <v-btn
                  nuxt
                  large
                  rounded
                  text
                  @click="goToSeeMore()"
                  class="btn-custom-md"
                  depressed
                  color="white"
                  elevation="0"
                >
                  Ver mais
                </v-btn>
                <v-btn
                  nuxt
                  large
                  rounded
                  text
                  @click="openEditDialog()"
                  class="btn-custom-md"
                  depressed
                  color="white"
                  elevation="0"
                >
                  Editar artigo
                </v-btn>
                <v-dialog
                  v-model="confirm_dialog"
                  persistent
                  max-width="290"
                >
                  <template v-slot:activator="{ on, attrs }">
                    <v-btn
                      nuxt
                      large
                      rounded
                      text
                      class="btn-custom-md"
                      depressed
                      color="white"
                      elevation="0"
                      v-bind="attrs"
                      v-on="on"
                    >
                      Excluir artigo
                    </v-btn>
                  </template>
                  <v-card>
                    <v-card-title class="text-h5">
                      Tem certeza ?
                    </v-card-title>
                    <v-card-text>O artigo será apagado permenetemente.</v-card-text>
                    <v-card-actions>
                      <v-spacer></v-spacer>
                      <v-btn
                        color="error"
                        text
                        @click="confirm_dialog = false"
                      >
                        Cancelar
                      </v-btn>
                      <v-btn
                        color="success"
                        text
                        @click="deleteArticle()"
                      >
                        Continuar
                      </v-btn>
                    </v-card-actions>
                  </v-card>
                </v-dialog>
              </div>
            </div>
          </v-col>
          <v-col v-if="image_side == 'right'" cols="12" md="5" lg="5">
            <v-img
              :src="article.imageUrl"
              alt="banner"
            />
          </v-col>
        </v-row>
        <div v-if="is_the_last_article_displayed" class="mt-16 pt-16 d-flex justify-center" fluid>
          <v-btn
            :disabled="is_more_articles_button_disabled"
            nuxt
            large
            rounded
            class="btn-custom-md"
            depressed
            color="white"
            elevation="0"
            @click="$emit('getNewArticles')"
          >
            {{is_more_articles_button_disabled ? 'Não há mais artigos' : 'Carregar mais'}}
          </v-btn>
        </div>
        <article-dialog :dialog_edit="dialog_edit" :article="article" @reloadArticles="reloadArticles"></article-dialog>
      </v-container>
    </div>
  </div>
</template>
<script>
import dayjs from 'dayjs'
import Api from '@/api'
export default {
  name: "Banner1",
  components: {
    ArticleDialog: () => import("@/components/articles/ArticleDialog")
  },
  props: {
    background_color: {
      type: String,
      default: ()=> ''
    },
    image_side: {
      type: String,
      default: ()=> ''
    },
    is_the_last_article_displayed: {
      type: Boolean,
      default: ()=> null
    },
    article: {
      type: Object,
      default: ()=> null
    },
    is_more_articles_button_disabled: {
      type: Boolean,
      default: ()=> null
    },
  },
  data() {
    return {
      dialog_edit: false,
      article_to_edit: {},
      loading: false,
      confirm_dialog: false
    };
  },
  mounted() {
    this.setArticleToEdit()
  },
  computed: {
    article_data(){
      return dayjs(this.article.publishedAt).format('MMMM DD, YYYY')
    }
  },
  methods: {
    goToSeeMore(){
      window.open(this.article.url, '_blank');
    },
    deleteArticle(){
      Api.Articles.delete(this.article.id).then(()=>{
        this.reloadArticles()
      })
    },
    setArticleToEdit(){
      this.loading = false
      this.article_to_edit = this.article
      this.loading = true
    },
    openEditDialog(){
      this.dialog_edit = true
    },
    reloadArticles(){
        this.$emit('reloadArticles')
        this.dialog_edit = false
    },
  }
};
</script>
