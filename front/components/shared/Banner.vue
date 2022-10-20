<template>
  <div class="banner-wrapper">
    <v-container>
      <!-- -----------------------------------------------
            Start Banner
        ----------------------------------------------- -->
      <v-row justify="center">
        <v-col cols="12" class="d-block justify-center">
          <logo style="max-width: 150px;margin: auto;" class="mb-n15"></logo>
          <div class="text-center">
            <h1 class="banner-title font-weight-bold white--text">
              Space Flight News
            </h1>
          </div>
        </v-col>
      </v-row>

      <!-- -----------------------------------------------
            End Banner
        ----------------------------------------------- -->
    </v-container>
  </div>
</template>
<script>
export default {
  name: "Banner",
  components: {
    Logo: () => import("@/layouts/sections/Logo")
  },
  data() {
    return {};
  }
};
</script>
