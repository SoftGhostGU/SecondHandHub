<script setup>
import { Edit, Delete } from "@element-plus/icons-vue";
import { ref } from "vue";
//声明一个异步的函数
const categorys = ref([]);
import {
  goodsCategoryListService,
  goodsCategoryAddService,
  goodsCategoryUpdateService,
  goodsCategoryDeleteService,
  goodsAllListService,
} from "@/api/goods.js";
const goodsCategoryList = async () => {
  let result = await goodsCategoryListService();
  categorys.value = result.data;
};
goodsCategoryList();
//控制添加分类弹窗
const dialogVisible = ref(false);

//添加分类数据模型
const categoryModel = ref({
  categoryName: "",
  categoryAlias: "",
});
//添加分类表单校验
const rules = {
  categoryName: [
    { required: true, message: "请输入分类名称", trigger: "blur" },
  ],
  categoryAlias: [
    { required: true, message: "请输入分类别名", trigger: "blur" },
  ],
};

//调用接口,添加表单
import { ElMessage } from "element-plus";
const addCategory = async () => {
  //调用接口
  let result = await goodsCategoryAddService(categoryModel.value);
  ElMessage.success(result.msg ? result.msg : "添加成功");

  //调用获取所有文章分类的函数
  goodsCategoryList();
  dialogVisible.value = false;
};

//定义变量,控制标题的展示
const title = ref("");

//展示编辑弹窗
const showDialog = (row) => {
  dialogVisible.value = true;
  title.value = "编辑分类";
  //数据拷贝
  categoryModel.value.categoryName = row.categoryName;
  categoryModel.value.categoryDetail = row.categoryDetail;
  //扩展id属性,将来需要传递给后台,完成分类的修改
  categoryModel.value.id = row.id;
};

//编辑分类
const updateCategory = async () => {
  //调用接口
  let result = await goodsCategoryUpdateService(categoryModel.value);

  ElMessage.success(result.msg ? result.msg : "修改成功");

  //调用获取所有分类的函数
  goodsCategoryList();

  //隐藏弹窗
  dialogVisible.value = false;
};

//清空模型的数据
const clearData = () => {
  categoryModel.value.categoryName = "";
  categoryModel.value.categoryAlias = "";
};

//删除分类
import { ElMessageBox } from "element-plus";
const deleteCategory = (row) => {
  //提示用户  确认框

  ElMessageBox.confirm("你确认要删除该分类信息吗?", "温馨提示", {
    confirmButtonText: "确认",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      //调用接口
      let result = await goodsCategoryDeleteService(row.id);
      ElMessage({
        type: "success",
        message: "删除成功",
      });
      //刷新列表
      goodsCategoryList();
    })
    .catch(() => {
      ElMessage({
        type: "info",
        message: "用户取消了删除",
      });
    });
};

import AllGoodsCard from "../../components/AllGoodsCard.vue";
const goods = ref([]);
const categoryId = ref("");
const state = ref("");

//分页条数据模型
const pageNum = ref(1); //当前页
const total = ref(20); //总条数
const pageSize = ref(8); //每页条数

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

// 获取当前用户的id
import { userInfoService } from "@/api/user.js";
const getUserId = async () => {
  let result = await userInfoService();
  return result.data.id;
};
console.log(getUserId());

//获取商品列表数据
const goodsList = async () => {
  let params = {
    pageNum: pageNum.value,
    pageSize: pageSize.value,
    categoryId: categoryId.value ? categoryId.value : null,
    // state: state.value ? state.value : null,
    state: "未被购买",
  };
  let result = await goodsAllListService(params);

  let id = await getUserId();

  //渲染视图
  total.value = result.data.total;
  // 筛选出不是自己的商品
  goods.value = result.data.items.filter((item) => item.createUser != id);

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
</script>
<template>
  <div class="category-container">
    <el-card class="page-container">
      <template #header>
        <div class="header">
          <span>物品分类</span>
          <div class="extra">
            <el-button
              type="primary"
              @click="
                dialogVisible = true;
                title = '添加分类';
                clearData();
              "
              >添加分类</el-button
            >
          </div>
        </div>
      </template>
      <el-table :data="categorys" style="width: 100%" class="category-table">
        <el-table-column label="序号" type="index" class="category-index">
        </el-table-column>
        <el-table-column label="分类名称" prop="categoryName"></el-table-column>
        <el-table-column
          label="具体分类"
          prop="categoryDetail"
        ></el-table-column>
        <el-table-column label="操作" width="100">
          <template #default="{ row }">
            <el-button
              :icon="Edit"
              circle
              plain
              type="primary"
              @click="showDialog(row)"
            ></el-button>
            <el-button
              :icon="Delete"
              circle
              plain
              type="danger"
              @click="deleteCategory(row)"
            ></el-button>
          </template>
        </el-table-column>
        <template #empty>
          <el-empty description="没有数据" />
        </template>
      </el-table>

      <!-- 添加分类弹窗 -->
      <el-dialog v-model="dialogVisible" :title="title" width="30%">
        <el-form
          :model="categoryModel"
          :rules="rules"
          label-width="100px"
          style="padding-right: 30px"
        >
          <el-form-item label="分类名称" prop="categoryName">
            <el-input
              v-model="categoryModel.categoryName"
              minlength="1"
              maxlength="10"
            ></el-input>
          </el-form-item>
          <el-form-item label="具体分类" prop="categoryDetail">
            <el-input
              v-model="categoryModel.categoryDetail"
              minlength="1"
              maxlength="15"
            ></el-input>
          </el-form-item>
        </el-form>
        <template #footer>
          <span class="dialog-footer">
            <el-button @click="dialogVisible = false">取消</el-button>
            <el-button
              type="primary"
              @click="title == '添加分类' ? addCategory() : updateCategory()"
            >
              确认
            </el-button>
          </span>
        </template>
      </el-dialog>
    </el-card>
    <el-card class="goods-container">
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
        <AllGoodsCard
          class="goods-card"
          v-for="item in goods"
          :key="item.id"
          :id="item.id"
          :title="item.title"
          :content="item.content"
          :image="item.coverImg"
          :price="item.price"
          :createUser="item.createUser"
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
      <el-pagination
        v-model:current-page="pageNum"
        v-model:page-size="pageSize"
        :page-sizes="[8, 16, 32, 64]"
        layout="jumper, total, sizes, prev, pager, next"
        background
        :total="total"
        @size-change="onSizeChange"
        @current-change="onCurrentChange"
        style="margin-top: 20px; justify-content: flex-end"
      />
    </el-card>
  </div>
</template>

<style lang="scss" scoped>
.category-container {
  height: 100%;
  overflow-x: hidden;
  overflow-y: scroll;
}

.page-container {
  width: 25%;
  min-height: 100%;
  box-sizing: border-box;
  float: left;

  .category-table {
    width: 100%;
  }

  .category-index {
    width: 20%;
  }

  .header {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
}

.goods-container {
  width: 70%;
  margin-left: 2.5%;
  min-height: 100%;
  box-sizing: border-box;
  float: left;
}

.goods-list {
  display: flex;
  flex-wrap: wrap;
}

.goods-card {
  margin: 10px;
}
</style>