<script setup>
import { Edit, Delete } from "@element-plus/icons-vue";

import GoodsCard from "@/components/GoodsCard.vue";

import { ref } from "vue";

//商品分类数据模型
const categorys = ref([]);

//用户搜索时选中的分类id
const categoryId = ref("");

//用户搜索时选中的发布状态
const state = ref("");

//商品列表数据模型
const goods = ref([]);

//分页条数据模型
const pageNum = ref(1); //当前页
const total = ref(20); //总条数
const pageSize = ref(12); //每页条数

//当每页条数发生了变化，调用此函数
const onSizeChange = (size) => {
  pageSize.value = size;
  goodsList();
};
//当前页码发生变化，调用此函数
const onCurrentChange = (num) => {
  pageNum.value = num;
  goodsList();
};

//回显商品分类
import {
  goodsCategoryListService,
  goodsListService,
  goodsAllListService,
  goodsAddService,
} from "@/api/goods.js";
const goodsCategoryList = async () => {
  let result = await goodsCategoryListService();

  categorys.value = result.data;
};

//获取商品列表数据
const goodsList = async () => {
  let params = {
    pageNum: pageNum.value,
    pageSize: pageSize.value,
    categoryId: categoryId.value ? categoryId.value : null,
    state: state.value ? state.value : null,
  };
  let result = await goodsListService(params);

  //渲染视图
  total.value = result.data.total;
  goods.value = result.data.items;

  //处理数据,给数据模型扩展一个属性categoryName,分类名称
  for (let i = 0; i < goods.value.length; i++) {
    let good = goods.value[i];
    for (let j = 0; j < categorys.value.length; j++) {
      if (good.categoryId == categorys.value[j].id) {
        good.categoryName = categorys.value[j].categoryName;
      }
    }
  }
};

goodsCategoryList();
goodsList();

import { QuillEditor } from "@vueup/vue-quill";
import "@vueup/vue-quill/dist/vue-quill.snow.css";
import { Plus } from "@element-plus/icons-vue";
//控制抽屉是否显示
const visibleDrawer = ref(false);
//添加表单数据模型
const goodsModel = ref({
  title: "",
  categoryId: "",
  price: 0,
  coverImg: "",
  content: "",
  state: "",
});

//导入token
import { useTokenStore } from "@/stores/token.js";
const tokenStore = useTokenStore();

//上传成功的回调函数
const uploadSuccess = (result) => {
  console.log(result);
  goodsModel.value.coverImg = "http://localhost:8080" + result;
};

//添加商品
import { ElMessage } from "element-plus";
const addGoods = async (clickState) => {
  //把发布状态赋值给数据模型
  goodsModel.value.state = clickState;

  //调用接口
  let result = await goodsAddService(goodsModel.value);

  ElMessage.success(result.msg ? result.msg : "添加成功");

  //让抽屉消失
  visibleDrawer.value = false;

  //刷新当前列表
  goodsList();
};
</script>
<template>
  <el-card class="page-container">
    <template #header>
      <div class="header">
        <span>商品管理</span>
        <div class="extra">
          <el-button type="primary" @click="visibleDrawer = true"
            >添加商品</el-button
          >
        </div>
      </div>
    </template>
    <!-- 搜索表单 -->
    <el-form inline>
      <el-form-item label="商品分类：">
        <el-select placeholder="请选择" v-model="categoryId">
          <el-option
            v-for="c in categorys"
            :key="c.id"
            :label="c.categoryName + ' / ' + c.categoryDetail"
            :value="c.id"
          >
          </el-option>
        </el-select>
      </el-form-item>

      <!-- <el-form-item label="发布状态：">
                <el-select placeholder="请选择" v-model="state">
                    <el-option label="已发布" value="已发布"></el-option>
                    <el-option label="草稿" value="草稿"></el-option>
                </el-select>
            </el-form-item> -->
      <el-form-item>
        <el-button type="primary" @click="goodsList">搜索</el-button>
        <el-button
          @click="
            categoryId = '';
            state = '';
          "
          >重置</el-button
        >
      </el-form-item>
    </el-form>
    <!-- 商品卡片列表 -->
    <div class="goods-list">
      <GoodsCard
        class="goods-card"
        v-for="item in goods"
        :key="item.id"
        :title="item.title"
        :image="item.coverImg"
        :price="item.price"
        :state="item.state"
        @addToCart="() => handleAddToCart(item)"
        @buyNow="() => handleBuyNow(item)"
      />
    </div>

    <!-- 商品列表 -->
    <!-- <el-table :data="goods" style="width: 100%">
            <el-table-column label="商品标题" width="400" prop="title"></el-table-column>
            <el-table-column label="分类" prop="categoryName"></el-table-column>
            <el-table-column label="发表时间" prop="createTime"> </el-table-column>
            <el-table-column label="状态" prop="state"></el-table-column>
            <el-table-column label="操作" width="100">
                <template #default="{ row }">
                    <el-button :icon="Edit" circle plain type="primary"></el-button>
                    <el-button :icon="Delete" circle plain type="danger"></el-button>
                </template>
            </el-table-column>
            <template #empty>
                <el-empty description="没有数据" />
            </template>
        </el-table> -->
    <!-- 分页条 -->
    <el-pagination v-model:current-page="pageNum" v-model:page-size="pageSize" :page-sizes="[12, 24, 48, 96]"
            layout="jumper, total, sizes, prev, pager, next" background :total="total" @size-change="onSizeChange"
            @current-change="onCurrentChange" style="margin-top: 20px; justify-content: flex-end" />

    <!-- 抽屉 -->
    <el-drawer
      v-model="visibleDrawer"
      title="添加商品"
      direction="rtl"
      size="50%"
    >
      <!-- 添加商品表单 -->
      <el-form :model="goodsModel" label-width="100px">
        <el-form-item label="商品标题">
          <el-input
            v-model="goodsModel.title"
            placeholder="请输入标题"
          ></el-input>
        </el-form-item>
        <el-form-item label="商品价格">
          <el-input
            v-model="goodsModel.price"
            placeholder="请输入价格"
          ></el-input>
        </el-form-item>
        <el-form-item label="商品分类">
          <el-select placeholder="请选择" v-model="goodsModel.categoryId">
            <el-option
              v-for="c in categorys"
              :key="c.id"
              :label="c.categoryName + ' / ' + c.categoryDetail"
              :value="c.id"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="商品封面">
          <!-- 
                        auto-upload:设置是否自动上传
                        action:设置服务器接口路径
                        name:设置上传的文件字段名
                        headers:设置上传的请求头
                        on-success:设置上传成功的回调函数
                     -->

          <el-upload
            class="avatar-uploader"
            :auto-upload="true"
            :show-file-list="false"
            action="/api/other/uploadPhoto"
            name="file"
            :headers="{ Authorization: tokenStore.token }"
            :on-success="uploadSuccess"
          >
            <img
              v-if="goodsModel.coverImg"
              :src="goodsModel.coverImg"
              class="avatar"
            />
            <el-icon v-else class="avatar-uploader-icon">
              <Plus />
            </el-icon>
          </el-upload>
        </el-form-item>
        <el-form-item label="商品内容">
          <div class="editor">
            <quill-editor
              theme="snow"
              v-model:content="goodsModel.content"
              contentType="html"
            >
            </quill-editor>
          </div>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="addGoods('未被购买')">发布</el-button>
          <!-- <el-button type="info" @click="addGoods('草稿')">草稿</el-button> -->
        </el-form-item>
      </el-form>
    </el-drawer>
  </el-card>
</template>
<style lang="scss" scoped>
.page-container {
  min-height: 100%;
  box-sizing: border-box;

  .header {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
}

.goods-list {
  display: flex;
  flex-wrap: wrap;
}

.goods-card {
  margin: 10px;
}

/* 抽屉样式 */
.avatar-uploader {
  :deep() {
    .avatar {
      width: 178px;
      height: 178px;
      display: block;
    }

    .el-upload {
      border: 1px dashed var(--el-border-color);
      border-radius: 6px;
      cursor: pointer;
      position: relative;
      overflow: hidden;
      transition: var(--el-transition-duration-fast);
    }

    .el-upload:hover {
      border-color: var(--el-color-primary);
    }

    .el-icon.avatar-uploader-icon {
      font-size: 28px;
      color: #8c939d;
      width: 178px;
      height: 178px;
      text-align: center;
    }
  }
}

.editor {
  width: 100%;

  :deep(.ql-editor) {
    min-height: 200px;
  }
}
</style>