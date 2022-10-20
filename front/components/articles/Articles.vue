<template>
  <div>
    <div v-if="!loading || articles != []" v-for="(article, index) in articles" :key="article.id">
      <article-banner
      @getNewArticles="getData()"
      @reloadArticles="reloadArticles()"
      :article="article"
      background_color="background: rgb(255,177,105);background: linear-gradient(270deg, rgba(255,177,105,1) 45%, rgba(128,89,52,1) 100%);"
      :image_side="index % 2 == 0 ? 'left' : 'right'"
      :is_the_last_article_displayed="(index == articles.length-1)"
      :is_more_articles_button_disabled="is_more_articles_button_disabled"
      ></article-banner>
    </div>
    <v-dialog v-if="loading" v-model="loading" width="500" height="500" style="border-radius: 0px!important;">
      <card-loading></card-loading>
    </v-dialog>
  </div>
</template>
<script>
import axios from "axios";
import Api from '@/api'
export default {
  name: "Articles",
  props: {
    is_filter_by_oldest: {
      type: Boolean,
      default: ()=> false
    },
    search: {
      type: String,
      default: ()=> ''
    }
  },
  components: {
    ArticleBanner: () => import("@/components/articles/ArticleBanner"),
    CardLoading: () => import("@/components/shared/CardLoading"),
  },
  data() {
    return {
      is_more_articles_button_disabled: false,
      page: 1,
      loading: false,
      articles: [],
      aux_image_side: 'right',
    };
  },
  methods: {
    reloadArticles(){
      this.resetData()
      this.getData()
    },
    resetData(){
      this.articles = []
      this.page = 1
    },
    async getData(is_direction_sort_changed, search){
      this.loading = true
      window.scrollTo(0, document.body.scrollHeight)
      if(is_direction_sort_changed){
        this.resetData()
      }
      let aux_articles = await this.getArticles(search)
      setTimeout(() => {
        this.articles = aux_articles
        this.loading = false
      }, 600);
    },
    async getArticles(search){
      let filter = {
        page: this.page,
        limit: 10,
        sort_dir: this.is_filter_by_oldest ? 'asc' : 'desc',
        search: search || ''
      }
      return await Api.Articles.index(filter).then((r)=>{
        this.page = (this.page+1)
        let new_articles = r.data.data
        let old_articles = this.articles
        let total_loaded_articles = [...old_articles, ...new_articles]
        total_loaded_articles.length == r.data.total ? this.is_more_articles_button_disabled = true : this.is_more_articles_button_disabled = false
        return total_loaded_articles
      })
    },
    setDataBase(){
      // let data = ''
      axios
      .get('https://api.spaceflightnewsapi.net/v3/articles')
      .then((r)=>{
        r.data.forEach((d)=> {
          let article = {
            id: null,
            ...d
          }
          Api.Articles.create(article)
        })
      })
    }
  },
  computed: {
  },
  mounted() {
    this.getData()
  },
  watch: {
    is_filter_by_oldest(){
      this.getData(true, this.search)
    },
    search(){
      this.getData(true, this.search)
    },
    background_gradient(){
      return 'background: rgb(255,177,105);background: linear-gradient(150deg, rgba(255,177,105,1) 33%, rgba(48,46,83,1) 100%);'
      
      
    }
  },
};
</script>
