/* eslint-disable */
import Vue from "vue";
import axios from "axios";
import VueAxios from "vue-axios";

Vue.use(VueAxios, axios);
Vue.axios.defaults.baseURL = 'http://localhost:3000/api/v1';

const axiosInstance = axios.create({
  baseURL: 'http://localhost:3000/api/v1',
  // withCredentials: true,
  headers: {
    "Content-Type": "application/json"
  }
});

axiosInstance.interceptors.request.use(
  config => {
    config.method.toUpperCase();
    config.headers = {
      ...config.headers,
      "Content-Type": "application/json",
      "token-type": localStorage.auth_token_default
        ? localStorage.auth_token_default.split("|")[0]
        : null,
      "access-token": localStorage.auth_token_default
        ? localStorage.auth_token_default.split("|")[1]
        : null,
      client: localStorage.auth_token_default
        ? localStorage.auth_token_default.split("|")[2]
        : null,
      uid: localStorage.auth_token_default
        ? localStorage.auth_token_default.split("|")[3]
        : null,
      expiry: localStorage.auth_token_default
        ? localStorage.auth_token_default.split("|")[4]
        : null
    };
    // console.log("Request:", config);
    return config;
  },
  error => {
    // alert("Ops! Algo errado com a requisição.");
    // console.log(error);
    return Promise.reject(error);
  }
);

axiosInstance.interceptors.response.use(
  function(response) {
    if (response.headers["access-token"]) {
      const token = [
        response.headers["token-type"],
        response.headers["access-token"],
        response.headers.client,
        response.headers.uid,
        response.headers.expiry
      ].join("|");
      localStorage.auth_token_default = token;
    }
    return response;
  },
  function(error) {
    return Promise.reject(error);
  }
);

export default { axiosInstance };
/* eslint-enable */
