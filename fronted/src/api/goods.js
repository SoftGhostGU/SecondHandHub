import request from '@/utils/request.js'
import { useTokenStore } from '@/stores/token.js'
//文章分类列表查询
export const goodsCategoryListService = ()=>{
    //const tokenStore = useTokenStore();
    //在pinia中定义的响应式数据,都不需要.value
    //return request.get('/category',{headers:{'Authorization':tokenStore.token}})
    return request.get('/category/list')
}

//文章分类添加
export const goodsCategoryAddService = (categoryData)=>{
    return request.post('/category/add',categoryData)
}

//文章分类修改
export const goodsCategoryUpdateService = (categoryData)=>{
   return  request.put('/category/update',categoryData)
}

//文章分类删除
export const goodsCategoryDeleteService = (id)=>{
    return request.delete('/category/delete?id='+id)
}

//文章列表查询
export const goodsListService = (params)=>{
   return  request.get('/goods/list',{params:params})
}

//文章全部列表查询
export const goodsAllListService = (params)=>{
    return request.get('/goods/listAll',{params:params})
}

//文章添加
export const goodsAddService = (articleData)=>{
    return request.post('/goods/add',articleData);

}