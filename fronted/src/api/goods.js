import request from '@/utils/request.js'
import { useTokenStore } from '@/stores/token.js'
//物品分类列表查询
export const goodsCategoryListService = ()=>{
    //const tokenStore = useTokenStore();
    //在pinia中定义的响应式数据,都不需要.value
    //return request.get('/category',{headers:{'Authorization':tokenStore.token}})
    return request.get('/category/list')
}

//物品分类添加
export const goodsCategoryAddService = (categoryData)=>{
    return request.post('/category/add',categoryData)
}

//物品分类修改
export const goodsCategoryUpdateService = (categoryData)=>{
   return  request.put('/category/update',categoryData)
}

//物品分类删除
export const goodsCategoryDeleteService = (id)=>{
    return request.delete('/category/delete?id='+id)
}

//物品列表查询
export const goodsListService = (params)=>{
   return  request.get('/goods/list',{params:params})
}

//物品全部列表查询
export const goodsAllListService = (params)=>{
    return request.get('/goods/listAll',{params:params})
}

//物品添加
export const goodsAddService = (articleData)=>{
    return request.post('/goods/add',articleData);
}

//物品修改
export const goodsUpdateService = (articleData)=>{
    return request.post('/goods/update',articleData);
}

//查询物品
export const goodsDetailService = (id)=> {
    return request.get('/goods/get?id='+id)
}

//购买物品
export const goodsBuyService = (params)=>{
    return request.post('/goods/buy',params)
}