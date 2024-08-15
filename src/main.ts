import './assets/main.css';
import '@patternfly/patternfly/patternfly.scss';

import { createApp } from 'vue';
import { createPinia } from 'pinia';
import VuePatternFly from '@vue-patternfly/core';
import App from './App.vue';

const app = createApp(App);

app.use(createPinia());
app.use(VuePatternFly);
app.mount('#app');
