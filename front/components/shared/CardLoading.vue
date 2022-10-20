<template>
  <div>
      <v-card class="py-15">
        <v-card-text>
          <v-row
            class="fill-height"
            align-content="center"
            justify="center"
          >
            <v-col
              class="text-subtitle-1 text-center"
              cols="12"
            >
              Carregando artigos...
            </v-col>
            <v-col cols="6">
              <v-progress-linear
                color="#FFB169"
                indeterminate
                rounded
                height="6"
              ></v-progress-linear>
            </v-col>
          </v-row>
        </v-card-text>
      </v-card>
  </div>
</template>
<script>
export default {
  name: "Banner",
  components: {
    Logo: () => import("@/layouts/sections/Logo")
  },
  data() {
    return {
      dialog: true,
    };
  }
};
</script>
