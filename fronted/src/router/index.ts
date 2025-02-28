import { createRouter, createWebHistory } from 'vue-router'
import SecondHandHub from '@/views/SecondHandHubView.vue'
import Login from '@/views/LoginView.vue'
import UserInfo from '@/views/UserInfoView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'SecondHandHub',
      component: SecondHandHub,
    },
    {
      path: '/login',
      name: 'login',
      component: Login
    },
    {
      path: '/UserInfo',
      name: 'UserInfo',
      component: UserInfo
    }
  ],
})

export default router
