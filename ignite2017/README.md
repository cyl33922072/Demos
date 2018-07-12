产品按照服务形态可以分为：

1. 资源型，如Ecs、Rds等
2. 服务型，如API网关、Cdn等
3. 存储型，如对象存储OSS、日志服务等
4. 数据型，如OCR、智能语音交互等

其中资源型产品均具备“实例”概念，其他资源可以被理解为“实例”，故可以通过规范实例的创建、删除、修改、查询等接口来建立基线规范。而其他三种类型的产品，服务方式无统一模型，数据交互方式也各异，故无法建立通用的基线，需要产品自行向国际标准看齐。

# 资源型产品-实例管理类接口规范

## 实例管理类接口模块

资源型产品实例管理接口应至少包含以下几个模块，并且保证同意义的入参、出参与规范命名一致：

1. 创建&删除实例的接口
2. 启动&停止&重启实例的接口
3. 修改实例信息&修改实例规格&修改实例付费方式的接口
4. 查询一个/多个实例接口
5. 实例费用相关接口
6. DescribeRegions&DescribeZones

#### 创建&删除实例接口

**创建实例：CreateInstance**

请求参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>Action</td>
<td>String</td>
<td>系统规定参数。取值：CreateInstance</td>
</tr>
<tr>
<td>RegionId</td>
<td>String</td>
<td>指定实例所在的区域。产品需支持DescribeRegions接口供用户获取RegionId等信息</td>
</tr>
<tr>
<td>ZoneId</td>
<td>String</td>
<td>指定实例所属可用区的编号。产品需支持DescribeZones接口供用户查询可用区信息</td>
</tr>
<tr>
<td>InstanceName</td>
<td>String</td>
<td>实例的名称。
<li>长度为 [2, 128] 个英文或中文字符，必须以英文字母开头，可包含数字、点号（.）、下划线（_）或短横线（-）。</li>
<li>实例名称会显示在控制台。</li>
<li>如果没有指定该参数，默认值为实例的 InstanceId。</li>
<li>不能以 http:// 和 https:// 开头。</li>
</td>
</tr>
<tr>
<td>InstanceDescription</td>
<td>String</td>
<td>实例的描述或备注性信息。
<li>长度为 [2, 256] 个字符。必须以英文字母或中文开头，可包含数字、点号（.）、下划线（_）或短横线（-）。</li>
<li>实例描述会显示在控制台。</li>
<li>不填则为空，默认值为空。</li>
<li>不能以 http:// 和 https:// 开头。</li>
</td>
</tr>
<tr>
<td>InstanceSpec</td>
<td>String</td>
<td>指定实例规格。产品需支持DescribeInstanceSpecs接口供用户查询可购买规格。或支持实例规格文档</td>
</tr>
<tr>
<td>PayType</td>
<td>String</td>
<td>付费类型：
<li>Postpaid：后付费实例</li>
<li>Prepaid：预付费实例</li>
</td>
</tr>
<tr>
<td>PricingCycle</td>
<td>String</td>
<td>PayType为Prepaid时，指定购买实例的时长单位。取值：
<li>Week</li>
<li>Month</li>
<li>Year</li>
</td>
</tr>
<tr>
<td>Duration</td>
<td>String</td>
<td>PayType为Prepaid时，与PricingCycle联合指定购买时长。取值：依据产品实际支持的规格来指定</td>
</tr>
<tr>
<td>ClientToken</td>
<td>String</td>
<td>用于保证请求的幂等性。由客户端生成该参数值，要保证在不同请求间唯一。只支持 ASCII 字符，且不能超过 64 个字符</td>
</tr>
</table>

返回参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>RequestId</td>
<td>String</td>
<td>请求ID</td>
</tr>
<tr>
<td>InstanceId</td>
<td>String</td>
<td>实例ID</td>
</tr>
<tr>
<td>OrderId</td>
<td>String</td>
<td>订单ID</td>
</tr>
<tr>
<td>InstanceName</td>
<td>String</td>
<td>实例的名称</td>
</tr>
<tr>
<td>InstanceSpec</td>
<td>String</td>
<td>实例规格code</td>
</tr>
<tr>
<td>xxxAddress</td>
<td>String</td>
<td>视产品具体资源访问方式而定</td>
</tr>
</table>

**删除实例：DeleteInstance**

删除实例接口粒度为单个实例的操作。

请求参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>Action</td>
<td>String</td>
<td>系统规定参数。取值：DeleteInstance</td>
</tr>
<tr>
<td>InstanceId</td>
<td>String</td>
<td>指定要删除的实例的ID</td>
</tr>
</table>

返回参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>RequestId</td>
<td>String</td>
<td>请求ID</td>
</tr>
</table>

#### 启动&停止&重启实例的接口

**启动、停止、重启实例：StartInstance、StopInstance、RestartInstance**

启动&停止&重启实例接口的规范基本一致，这里把三个接口规范放在一个模板李。

请求参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>Action</td>
<td>String</td>
<td>系统规定参数。取值：
<li>启动实例：StartInstance</li>
<li>停止实例：StopInstance</li>
<li>重启实例：RestartInstance</li></td>
</tr>
<tr>
<td>InstanceId</td>
<td>String</td>
<td>指定要操作的实例的ID</td>
</tr>
</table>

返回参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>RequestId</td>
<td>String</td>
<td>请求ID</td>
</tr>
</table>

#### 修改实例相关信息接口

产品应至少分别支持用户对实例进行基本信息的修改、实例规格的修改、实例付费类型的修改。

- 修改实例基本信息：ModifyInstanceAttribute
- 修改实例规格：ModifyInstanceSpec
- 修改实例付费方式：ModifyInstancePayType

**修改实例基本信息：ModifyInstanceAttribute**

具体参数视产品实际业务参数而定，最基本要指定Action和InstanceId。

请求参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>Action</td>
<td>String</td>
<td>系统规定参数。取值：ModifyInstanceAttribute</td>
</tr>
<tr>
<td>InstanceId</td>
<td>String</td>
<td>指定要操作的实例的ID</td>
</tr>
<tr>
<td>InstanceName</td>
<td>String</td>
<td>实例的名称。
<li>长度为 [2, 128] 个英文或中文字符，必须以英文字母开头，可包含数字、点号（.）、下划线（_）或短横线（-）。</li>
<li>实例名称会显示在控制台。</li>
<li>如果没有指定该参数，默认值为实例的 InstanceId。</li>
<li>不能以 http:// 和 https:// 开头。</li>
</td>
</tr>
<tr>
<td>InstanceDescription</td>
<td>String</td>
<td>实例的描述或备注性信息。
<li>长度为 [2, 256] 个字符。必须以英文字母或中文开头，可包含数字、点号（.）、下划线（_）或短横线（-）。</li>
<li>实例描述会显示在控制台。</li>
<li>不填则为空，默认值为空。</li>
<li>不能以 http:// 和 https:// 开头。</li>
</td>
</tr>
</table>

返回参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>RequestId</td>
<td>String</td>
<td>请求ID</td>
</tr>
</table>

**修改实例规格：ModifyInstanceSpec**

请求参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>Action</td>
<td>String</td>
<td>系统规定参数。取值：ModifyInstanceSpec</td>
</tr>
<tr>
<td>InstanceId</td>
<td>String</td>
<td>指定要操作的实例的ID</td>
</tr>
<tr>
<td>InstanceSpec</td>
<td>String</td>
<td>指定实例规格。产品需支持DescribeInstanceSpecs接口供用户查询可购买规格。或支持实例规格文档</td>
</tr>
<tr>
<td>ClientToken</td>
<td>String</td>
<td>用于保证请求的幂等性。由客户端生成该参数值，要保证在不同请求间唯一。只支持 ASCII 字符，且不能超过 64 个字符</td>
</tr>
</table>

返回参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>RequestId</td>
<td>String</td>
<td>请求ID</td>
</tr>
<tr>
<td>InstanceId</td>
<td>String</td>
<td>实例ID</td>
</tr>
<tr>
<td>OrderId</td>
<td>String</td>
<td>订单ID</td>
</tr>
<tr>
<td>InstanceName</td>
<td>String</td>
<td>实例的名称</td>
</tr>
<tr>
<td>InstanceSpec</td>
<td>String</td>
<td>实例规格code</td>
</tr>
<tr>
<td>xxxAddress</td>
<td>String</td>
<td>视产品具体资源访问方式而定</td>
</tr>
</table>

**修改实例付费方式：ModifyInstancePayType**

支持用户将按量付费实例改为预付费实例。

请求参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>Action</td>
<td>String</td>
<td>系统规定参数。取值：ModifyInstancePayType</td>
</tr>
<tr>
<td>RegionId</td>
<td>String</td>
<td>指定实例所在的区域。产品需支持DescribeRegions接口供用户获取RegionId等信息</td>
</tr>
<tr>
<td>InstanceId</td>
<td>String</td>
<td>指定要操作的实例的ID</td>
</tr>
<tr>
<td>PayType</td>
<td>String</td>
<td>付费类型：
<li>Prepaid：预付费实例</li>
</td>
</tr>
<tr>
<td>PricingCycle</td>
<td>String</td>
<td>PayType为Prepaid时，指定购买实例的时长单位。取值：
<li>Week</li>
<li>Month</li>
<li>Year</li>
</td>
</tr>
<tr>
<td>Duration</td>
<td>String</td>
<td>PayType为Prepaid时，与PricingCycle联合指定购买时长。取值：依据产品实际支持的规格来指定</td>
</tr>
<tr>
<td>ClientToken</td>
<td>String</td>
<td>用于保证请求的幂等性。由客户端生成该参数值，要保证在不同请求间唯一。只支持 ASCII 字符，且不能超过 64 个字符</td>
</tr>
</table>

返回参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>RequestId</td>
<td>String</td>
<td>请求ID</td>
</tr>
<tr>
<td>InstanceId</td>
<td>String</td>
<td>实例ID</td>
</tr>
<tr>
<td>OrderId</td>
<td>String</td>
<td>订单ID</td>
</tr>
<tr>
<td>InstanceName</td>
<td>String</td>
<td>实例的名称</td>
</tr>
<tr>
<td>InstanceSpec</td>
<td>String</td>
<td>实例规格code</td>
</tr>
<tr>
<td>xxxAddress</td>
<td>String</td>
<td>视产品具体资源访问方式而定</td>
</tr>
</table>

#### 查询实例信息接口

支持查询单个实例的全部详细信息，支持查询实例列表。

- DescribeInstanceAttribute
- DescribeInstances

**批量查询实例列表：DescribeInstances**

请求参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>Action</td>
<td>String</td>
<td>系统规定参数。取值：DescribeInstances</td>
</tr>
<tr>
<td>RegionId</td>
<td>String</td>
<td>指定要查询的区域区域。产品需支持DescribeRegions接口供用户获取RegionId等信息</td>
<tr>
<td>InstanceIds</td>
<td>String</td>
<td>实例 ID。取值可以由多个实例 ID 组成一个 JSON 数组，格式为 ["i-xxxxxxxxx", "i-yyyyyyyyy", … "i-zzzzzzzzz"]，最多支持 100 个 ID，ID 之间用半角逗号（,）隔开。</td>
</tr>
</table>

返回参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>RequestId</td>
<td>String</td>
<td>请求ID</td>
</tr>
<tr>
<td>TotalCount</td>
<td>Integer</td>
<td>总记录数</td>
</tr>
<tr>
<td>PageSize</td>
<td>Integer</td>
<td>本页条数</td>
</tr>
<tr>
<td>PageNumber</td>
<td>Integer</td>
<td>页码</td>
</tr>
<tr>
<td>Instances</td>
<td>InstanceItemType</td>
<td>由InstanceItemType组成的数组，返回示例目录</td>
</tr>
</table>

InstanceItemType需要包含以下信息：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
<tr>
<td>InstanceId</td>
<td>String</td>
<td>实例ID</td>
</tr>
<tr>
<td>InstanceName</td>
<td>String</td>
<td>实例的名称</td>
</tr>
<tr>
<td>RegionId</td>
<td>String</td>
<td>指定实例所在的区域。产品需支持DescribeRegions接口供用户获取RegionId等信息</td>
</tr>
<tr>
<td>ZoneId</td>
<td>String</td>
<td>指定实例所属可用区的编号。产品需支持DescribeZones接口供用户查询可用区信息</td>
</tr>
<tr>
<td>InstanceSpec</td>
<td>String</td>
<td>实例规格code</td>
</tr>
<tr>
<td>xxxAddress</td>
<td>String</td>
<td>视产品具体资源访问方式而定</td>
</tr>
<tr>
<td>InstanceDescription</td>
<td>String</td>
<td>实例的描述或备注性信息</td>
</tr>
<tr>
<td>PayType</td>
<td>String</td>
<td>付费类型</td>
</tr>
<tr>
<td>PricingCycle</td>
<td>String</td>
<td>PayType为Prepaid时，购买实例的时长单位</td>
</tr>
<tr>
<td>Duration</td>
<td>String</td>
<td>PayType为Prepaid时，与PricingCycle联合指定的购买时长</td>
</tr>
<tr>
<td>InstanceStatus</td>
<td>String</td>
<td>实例状态。具体取值视产品业务形态而定</td>
</tr>
<tr>
<td>CreationTime</td>
<td>String</td>
<td>创建时间。使用 UTC 时间。格式为 YYYY-MM-DDThh:mm:ssZ</td>
</tr>
<tr>
<td>ExpiredTime</td>
<td>String</td>
<td>过期时间。使用 UTC 时间。格式为 YYYY-MM-DDThh:mm:ssZ</td>
</tr>
</table>

**查询单个实例详情：DescribeInstanceAttribute**

请求参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>Action</td>
<td>String</td>
<td>系统规定参数。取值：DescribeInstanceAttribute</td>
</tr>
<tr>
<td>InstanceId</td>
<td>String</td>
<td>实例 ID</td>
</tr>
</table>

返回参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>RequestId</td>
<td>String</td>
<td>请求ID</td>
<tr>
<td>InstanceId</td>
<td>String</td>
<td>实例ID</td>
</tr>
<tr>
<td>InstanceName</td>
<td>String</td>
<td>实例的名称</td>
</tr>
<tr>
<td>RegionId</td>
<td>String</td>
<td>指定实例所在的区域。产品需支持DescribeRegions接口供用户获取RegionId等信息</td>
</tr>
<tr>
<td>ZoneId</td>
<td>String</td>
<td>指定实例所属可用区的编号。产品需支持DescribeZones接口供用户查询可用区信息</td>
</tr>
<tr>
<td>InstanceSpec</td>
<td>String</td>
<td>实例规格code</td>
</tr>
<tr>
<td>xxxAddress</td>
<td>String</td>
<td>视产品具体资源访问方式而定</td>
</tr>
<tr>
<td>InstanceDescription</td>
<td>String</td>
<td>实例的描述或备注性信息</td>
</tr>
<tr>
<td>PayType</td>
<td>String</td>
<td>付费类型</td>
</tr>
<tr>
<td>PricingCycle</td>
<td>String</td>
<td>PayType为Prepaid时，购买实例的时长单位</td>
</tr>
<tr>
<td>Duration</td>
<td>String</td>
<td>PayType为Prepaid时，与PricingCycle联合指定的购买时长</td>
</tr>
<tr>
<td>InstanceStatus</td>
<td>String</td>
<td>实例状态。具体取值视产品业务形态而定</td>
</tr>
<tr>
<td>CreationTime</td>
<td>String</td>
<td>创建时间。使用 UTC 时间。格式为 YYYY-MM-DDThh:mm:ssZ</td>
</tr>
<tr>
<td>ExpiredTime</td>
<td>String</td>
<td>过期时间。使用 UTC 时间。格式为 YYYY-MM-DDThh:mm:ssZ</td>
</tr>
</table>

#### 实例费用管理相关接口

产品应支持用户通过API接口做实例费用的相关管理和查询：

- 查询实例规格列表：DescribeInstanceSpecs。支持用户调用API获取产品在售的所有规格配置列表
- 实例询价接口：DescribeInstancePrice。支持用户通过调用API获取某个规格组合的实例报价
- 为预付费类型实例续费：RenewInstance
- 查询产品支持的区域：DescribeRegions
- 查询产品支持的可用区：DescribeZones

**为预付费实例续费：RenewInstance**

请求参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>Action</td>
<td>String</td>
<td>系统规定参数。取值：RenewInstance</td>
</tr>
<tr>
<td>InstanceId</td>
<td>String</td>
<td>指定要操作的实例的ID</td>
</tr>
<tr>
<td>PricingCycle</td>
<td>String</td>
<td>PayType为Prepaid时，指定购买实例的时长单位。取值：
<li>Week</li>
<li>Month</li>
<li>Year</li>
</td>
</tr>
<tr>
<td>Duration</td>
<td>String</td>
<td>PayType为Prepaid时，与PricingCycle联合指定购买时长。取值：依据产品实际支持的规格来指定</td>
</tr>
<td>ClientToken</td>
<td>String</td>
<td>用于保证请求的幂等性。由客户端生成该参数值，要保证在不同请求间唯一。只支持 ASCII 字符，且不能超过 64 个字符</td>
</tr>
</table>

返回参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>RequestId</td>
<td>String</td>
<td>请求ID</td>
</tr>
<tr>
<td>InstanceId</td>
<td>String</td>
<td>实例ID</td>
</tr>
<tr>
<td>PricingCycle</td>
<td>String</td>
<td>续费后的购买时长单位</td>
</tr>
<tr>
<td>Duration</td>
<td>String</td>
<td>续费后的购买时长。与PricingCycle联合指定的购买时长</td>
</tr>
<tr>
<td>ExpiredTime</td>
<td>String</td>
<td>过期时间。使用 UTC 时间。格式为 YYYY-MM-DDThh:mm:ssZ</td>
</tr>
</table>

**查询产品支持的区域：DescribeRegions**

请求参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>Action</td>
<td>String</td>
<td>系统规定参数。取值：DescribeRegions</td>
</tr>
<tr>
<td>AcceptLanguage</td>
<td>String</td>
<td>参照国际标准<a target="_blank" href="https://tools.ietf.org/html/rfc7231" class="bi-link">RFC7231</a>，后端服务需要按用户语言要求返回结果：
<li>默认值:无</li>
<li>中文：zh-CN</li>
<li>英文：en-US</li>
<li>日文：ja</li></td>
</tr>
</table>

返回参数：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>RequestId</td>
<td>String</td>
<td>请求ID</td>
</tr>
<tr>
<td>Regions（可保持原有命名）</td>
<td>RegionType（可保持原有命名）</td>
<td>地域信息 RegionType 组成的集合</td>
</tr>
</table>

Regions的Info信息Type里应至少包含：

<table border="1">
<tr>
<th>名称</th>
<th>类型</th>
<th>描述</th>
</tr>
<tr>
<td>RegionId</td>
<td>String</td>
<td>Region ID</td>
</tr>
<tr>
<td>LocalName</td>
<td>String</td>
<td>Region名称</td>
</tr>
<tr>
<td>RegionEndpoint</td>
<td>String</td>
<td>Region服务的Endpoint地址。可同location获取，<a target="_blank" href="https://lark.alipay.com/aone619864/location-service/asm989" class="bi-link">接口</a></td>
</tr>
</table>

**查询产品支持的区域：DescribeZones**

通用兼容规范待整理

# 存储&数据型产品

对象存储 OSS 已经兼容了
块存储 kongwen
文件存储 NAS 王登宇
归档存储 OAS  与OSS一起兼容了
表格存储（Restful API，只提供SDK） OTS，没有竞品
智能语音交互 
人脸识别 
图像识别 
公众趋势分析（？）没有竞品
企业图谱（？）没有竞品





