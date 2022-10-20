<template>
  <div>
    <Header @reloadArticles="reloadArticles" @filterBySearch="setSearch" @filterByOldest="is_filter_by_oldest = true" @filterByNewest="is_filter_by_oldest = false"/>
    <Banner />
    <articles ref="articles" :is_filter_by_oldest="is_filter_by_oldest" :search="search"></articles>
    <Footer/>
  </div>
</template>

<script>
export default {
  head() {
    return {
      title: "Space Flight News | Articles",
    };
  },

  data() {
    return {
      is_filter_by_oldest: false,
      search: ''
    };
  },
  methods: {
    setSearch(nV){
      this.search = nV
    },
    reloadArticles(){
      this.$refs.articles.reloadArticles()
    }
  },  
  components: {
    Banner: () => import("@/components/shared/Banner"),
    Articles: () => import("@/components/articles/Articles"),
    Header: () => import("@/layouts/sections/Header"),
    Footer: () => import("@/layouts/sections/Footer")
  },
};
</script>
