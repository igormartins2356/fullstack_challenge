import Http from '../http'

export default {

  index(filter) {
    return Http.get(`/articles`, {params: {...filter}})
  },


  create(article){
    return Http.post(`/articles`, {article: {
      ...article,
    }})
  },

  update(article){
    return Http.put(`/articles/${article.id}`, {
      article: {
        ...article,
      },
    });
  },

  // show(id) {
  //   return Http.get(`/articles/${id}`);
  // },

  delete(id){
    return Http.delete(`/articles/${id}`)
  }

}