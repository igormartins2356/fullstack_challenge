<template>
  <div>
    <v-dialog v-model="dialog_edit" max-width="500px" persistent>
      <v-card>
        <v-toolbar
          dense
          color="#302E53"
          dark
          class="d-flex justify-center title"
        >Artigo: {{article_to_edit.title}}</v-toolbar>
        <v-card-text class="mt-9">
            <v-text-field v-model="article_to_edit.title" label="Título" outlined></v-text-field>
            <v-textarea v-model="article_to_edit.summary" label="Resumo" outlined></v-textarea>
        </v-card-text>
        <v-card-actions>
        <v-spacer></v-spacer>
          <v-btn
            color="error"
            text
            @click="closeEditDialog()"
          >
            Cancelar
          </v-btn>
          <v-btn
            color="success"
            text
            @click="is_component_used_in_create ? createArticle() : updateArticle()"
          >
            Confirmar
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>
<script>
import dayjs from 'dayjs'
import Api from '@/api'
export default {
  name: "Banner1",
  props: {
    article: {
      type: Object,
      default: ()=> null
    },
    dialog_edit: {
      type: Boolean,
      default: ()=> false
    },
    is_component_used_in_create: {
      type: Boolean,
      default: ()=> false
    },
  },
  data() {
    return {
      article_to_edit: {},
    };
  },
  mounted() {
    this.setArticleToEdit()
  },
  methods: {
    updateArticle(){
      Api.Articles.update(this.article).then(()=>{
        this.$emit('reloadArticles')
      })
    },
    prepareArticle(){
      let article = {
        title: this.article_to_edit.title,
        summary: this.article_to_edit.summary,
        newsSite: 'Fullstack Challenge',
        publishedAt: dayjs(),
        url: null,
        imageUrl: 'http://www.nasa.gov/sites/default/files/thumbnails/image/web_first_images_release.png'
      }
      return article
    },
    createArticle(){
      let article = this.prepareArticle()
      Api.Articles.create(article).then(()=>{
        this.$emit('reloadArticles')
      })
    },
    setArticleToEdit(){
      if(this.is_component_used_in_create){
        this.article_to_edit = {
          title: '',
          summary: '',

        }
      }else{
        this.article_to_edit = this.article
      }
    },
    closeEditDialog(){
      this.$emit('reloadArticles')
    },
  }
};
</script>
