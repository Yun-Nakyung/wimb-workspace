<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
<%@ page import="com.wimb.common.model.vo.PageInfo, java.util.ArrayList, com.wimb.product.model.vo.Product" %>
    
<%
	PageInfo pi = (PageInfo)(request.getAttribute("pi"));

	int currentPage = pi.getCurrentPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
	int maxPage = pi.getMaxPage();
	
	// 카테고리별 완제품  조회 => 상품코드, 상품명, 카테고리, 판매가격, 대표이미지, 재고수량, 파일경로
	ArrayList<Product> categoryList = (ArrayList<Product>)(request.getAttribute("categoryList"));
	
	// 카테고리 옵션별 응답 페이지에서 select option 유지에 사용할  value 값
	String selectOrder = (String)(request.getAttribute("selectOrder"));
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>완제품 목록</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
	.outer{
		box-sizing: border-box;
		/* border:1px solid red; */
		margin:auto;
		margin-top:50px;
		width:1000px;
		height:auto;
	}

	/* 타이틀 영역 */
	.product-list-area{
		box-sizing: border-box;
		/* border:1px solid red; */
		margin:auto;
		width:90%;
	}

	.title-area{
		box-sizing: border-box;
		/* border:1px solid red; */
		border-bottom:2px solid lightgray;
		margin:auto;
		margin-bottom: 20px;
		width:100%;
		height:50px;
		line-height: 50px;
	}

	.title-area>h4{
		font-weight: bolder;
		display:inline-block;
		margin-right:40px;
	}

	.title-area>a{
		margin-right:10px;
		color:black;
		text-decoration: none;
	}

	/* .title-area>a:{
		font-weight: border;
		font-size: large;
		color:#9BD5BD;
	} */

	/* 상품 정렬 목록 */
	.sort-list-area{
		box-sizing: border-box;
		/* border:1px solid red; */
		margin:auto;
		margin-bottom: 20px;
		width:100%;
		height:50px;
		line-height: 50px;
	}

	/* 상품 목록 */

	.product-area{
		box-sizing: border-box;
		/* border:1px solid red; */
		margin:auto;
		width:100%;
	}

	.product{
		box-sizing: border-box;
		/* border:1px solid red; */
		width:200px;
		height:260px;
		display: inline-block;
		margin-top: 20px;
		margin-right: 10px;
		margin-left: 10px;
		margin-bottom: 50px;
	}

	.product-img{
		box-sizing: border-box;
		/* border:1px solid red; */
		background: white;
		width:200px;
		height:200px;
		margin-bottom: 5px;
		position: relative;
		overflow: hidden;

		cursor:pointer;
	}

	.product-img>img{
		box-sizing: border-box;
		width:200px;
		height:200px;
		transform: scale(1);
		
	}

	.product-img>img:hover{
		transform: scale(1.05);
		transition-duration: 0.1s;
		
		
	}

	.heart-btn{
		position: absolute;
		left:10px;
		bottom:10px;
		color:#ffffff;
		text-shadow: 0px 0px 20px black;

		transform: scale(1);
	}

	.cart-btn{
		position: absolute;
		right:10px;
		bottom:10px;
		color:#ffffff;
		text-shadow: 0px 0px 20px black;

		transform: scale(1);
	}

	.heart-btn:hover, .cart-btn:hover{
		transform: scale(1.05);
		transition-duration: 0.1s;
	}

	.product h6{
		/* border:1px solid red; */
		/* display:inline-block; */
		font-size: 13px;
		font-weight: bolder;
	}
	.product h4{
		/* border:1px solid red; */
		/* display:inline-block; */
		font-weight: bolder;
		color: #9BD5BD
		
	}

	/* 페이징바 */

	#paging-bar{
        /* border:1px solid red; */
        width:900px;
        text-align:center;
    }


	/* 장바구니 모달창 */

	.cart-product{
		/* border:1px solid red; */
		width:100%;
		height:200px;
	}

	.cart-product-img{
		/* border:1px solid red; */
		width:200px; 
		height:200px; 
		float:left;
	}

	.cart-product-content{
		/* border:1px solid red; */
		width:264px; 
		height:200px; 
		float:left; 
		padding:20px; 
		padding-bottom:20px;
	}

	#amount{
		border:1px solid lightgray;
		width:50px;
		height:25px;
		text-align:center;
		margin:0 5px;
	}

	#cart-close-btn{
		background:white;
		border:1px solid lightgray;
		margin:0px 5px;
	}


	/* 모달창 배경 스타일 */

	.modal-backdrop {
		position: fixed;
		top: 0;
		left: 0;
		z-index: 1040;
		width: 100vw;
		height: 100vh;
		background-color: white !important;
	}

</style>
</head>
<body>
	<% if(selectOrder != null) { %>
	<script>
	
		$(function(){
			
			console.log("<%= selectOrder %>");
			
			$("select[name=selectOrder]").val("<%= selectOrder %>").prop("selected", true);

		});
	
	</script>
	<% } %>
	
	
	<%@ include file="../common/menubar.jsp" %>

	<div class="outer">
		<div class="product-list-area">

			<div class="title-area">
				<h4>샐러드</h4>
				<a href="<%= contextPath %>/list.pr?cpage=1">전체상품</a>
				<a href="<%= contextPath %>/veganList.pr?cpage=1">비건샐러드</a>
				<a href="<%= contextPath %>/meatList.pr?cpage=1">육류샐러드</a>
				<a href="<%= contextPath %>/seafoodList.pr?cpage=1">해산물샐러드</a>
			</div>

			<div class="sort-list-area" align="right">
				<select name="selectOrder" style="border:1px solid lightgray;">
					<option value="new">신상품순</option>
					<option value="hot">인기상품순</option>
					<option value="min">낮은가격순</option>
					<option value="max">높은가격순</option>
				</select>
			</div>

			<!-- select 옵션별 정렬용 -->
			<script>
				$(function(){

					$("select[name=selectOrder]").change(function(){
						const $option = $("option:selected").val();

						if($option == "new"){ // 신상품순일 경우
							location.href="<%= contextPath %>/seafoodList.pr?cpage=1";
						} else { // 그 외일 경우
							location.href="<%= contextPath %>/seafoodList.pr?cpage=1&selectOrder=" + $option;
						}

					});

				});
			</script>
			 
			<div class="product-area">
					
					<% for (Product p : categoryList) { %>
						<div class="product">
							<div class="product-img">
								<input type="hidden" name="pcode" value="<%= p.getpCode() %>">
								<input type="hidden" name="pPrice" id="" value="<%= p.getpPrice() %>">
								<input type="hidden" name="pName" id="" value="<%= p.getpName() %>">
								<img src="<%= contextPath %>/<%= p.getFilePath() + p.getpMainImg() %>">
							
								<!-- case1. 찜 안 했을 경우 -->
								<i class="far fa-heart fa-2x heart-btn"></i>
								<!-- case2. 찜 했을 경우 -->
								<!-- <i class="fas fa-heart fa-2x heart-btn"></i> -->
		
								<i class="fas fa-cart-plus fa-2x cart-btn add_cart"></i>
							</div>
		
							<h6><%=  p.getpName() %></h6>
							<% if(p.getDiscountPrice() != 0) { %>
								<!-- case1. 할인가 -->
								<span name="cost" style="text-decoration: line-through; color:lightgray; margin:0;" ><%= p.getpPrice() %>원</span>
								<h4 name="discount" style="color:salmon; display:inline-block; margin:0;">
									<span style="color:salmon; display:inline-block; margin:0;" class="discount"><%= p.getDiscountPrice() %></span>원
								</h4>
							<% } else {%>
								<!-- case2. 원가 -->
								<h4 style="margin:0;"><%= p.getpPrice() %>원</h4>
							<% } %>
						</div>
					<% } %>
				
			</div>
			<script>
				$(function(){
					// 상품 이미지 클릭 시 상세 페이지로 이동
					$(".product-img").on("click", "img", function(){
						
						location.href="<%= contextPath %>/detail.pr?pcode=" + $(this).parent().find("input[name=pcode]").val();
					});

					// 카트 아이콘 클릭 테스트용
					$(".product").on("click", ".cart-btn", function(){
						
						$("#cart-modal").modal("show");

					});

				});
			</script>


			<!-- 페이징바 -->
			<div id="paging-bar">
                <% if(currentPage != 1) { %>
						<% if(selectOrder != null) { %>
							<a class ="btn btn-sm" href="<%= contextPath %>/seafoodList.pr?cpage=<%= currentPage - 1 %>&selectOrder=<%= selectOrder %>">&lt;</a>
						<% } else { %>
							<a class ="btn btn-sm" href="<%= contextPath %>/seafoodList.pr?cpage=<%= currentPage - 1 %>">&lt;</a>
						<% } %>	
				<% } %>
                
                <% for(int p=startPage; p<=endPage; p++ ) { %>
                    <% if(p == currentPage) { %>
                        <a  class ="btn btn-sm" disabled><%= p %></a>
                    <% } else { %>
						<% if(selectOrder != null) { %>
							<a class ="btn btn-sm" href="<%= contextPath %>/seafoodList.pr?cpage=<%= p %>&selectOrder=<%= selectOrder %>"><%= p %></a>
						<% } else { %>
							<a class ="btn btn-sm" href="<%= contextPath %>/seafoodList.pr?cpage=<%= p %>"><%= p %></a>
						<% } %>	
                    <% } %>
                <% } %>
                
                <% if(currentPage != maxPage) { %>
					<% if(selectOrder != null) { %>
						<a class ="btn btn-sm" href="<%= contextPath %>seafoodList.pr?cpage=<%= currentPage + 1 %>&selectOrder=<%= selectOrder %>">&lt;</a>
					<% } else { %>
                        <a class ="btn btn-sm" href="<%= contextPath %>seafoodList.pr?cpage=<%= currentPage + 1 %>">&gt;</a>
					<% } %>	
                <% } %>
        </div>
            
		</div>
	</div>
	
	
	<%@ include file="../common/footer.jsp" %>
	<button id="cart-success-btn">장바구니 담기 성공 창 테스트</button>


	<!-- 장바구니 모달창 -->
    <div class="modal fade" id="cart-modal">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content cart-modal-content">
                
                <!-- Modal Header -->
                <div class="modal-header cart-title-area">
                    <h6 class="modal-title">장바구니 담기</h6>
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>
                
                <!-- Modal body -->
                <div class="modal-body cart-content-area">
                    <!--<form action="" id="cart-insert-form" method="get">-->
                      
						<div class="cart-product">
							<input type="hidden" name="cart-pCode">
							<div class="cart-product-img">
								<img src="" style="width:100%; height:100%;" class="productImg">
						   </div>

						   <div class="cart-product-content">
								
								<h4 id="cart-pName" style="font-weight:bolder; margin-bottom: 30px;" align="left" class="productName"></h4>
								<input type="hidden" class="productCode">

								<span>수량 선택</span>
								<span style="margin-left:50px;">
									<i class="fas fa-minus" onclick='count("minus")' value="-" style="cursor:pointer" style="color:lightgray;"></i>
									<input type="text" id="amount" name="amount" value="1" readonly>
									<i class="fas fa-plus" onclick='count("plus")' value="+" style="cursor:pointer"></i>
								</span>
								<hr>

								<h2 id="cart-pPrice" style="font-weight: bolder; color:#9BD5BD;" align="right"></h2>
								<h2 style="font-weight: bolder; color:#9BD5BD;" align="right">
									<span style="font-weight: bolder; color:#9BD5BD;" align="right" class="productPrice"></span>원	
								</h2>
								
						   
							</div>

							<!-- 수량 및 합계금액 표시 -->
							<script>
								function count(type) {
									
									// 수량 표시
									let $number = $("#amount").val(); // 수량 표시될 input 
									
									if(type == 'plus') {
										$number = parseInt($number) + 1;
									}else if(type == 'minus')  {
										if($number != '1'){
											$number = parseInt($number) - 1;
										} else{
											$number = 1;
										}
									}

									$("#amount").val($number);

									// 합계금액 표시
									//let $discount = $("#discount").text(); // 할인가
									let $cost = $(".productPrice").text(); // 원가
									let $num = $("#amount").val(); // 수량

									$(".productPrice").text($cost * $num);
								}

							</script>

					   </div>
					   
                    <!--</form>-->
                </div>
                
                <!-- Modal footer -->
                <div class="modal-footer button-area">
					<div class="btns" align="center" style="width:100%;">
						<button type="reset" id="cart-close-btn" class="btn btn-sm" data-dismiss="modal">취소</button>
						<button type="button" id="cart-insert-btn" class="btn btn-sm" style="background:#9BD5BD; margin:0px 5px;" onclick="addCartProduct();">등록</button>
					</div>
                </div>
            
            </div>
        </div>
    </div>

	<!-- 장바구니 담기 ajax (나경)-->
	<script>

		$(document).on("click", ".add_cart", function(){
			$("#amount").val(1);
			var productName = $(this).siblings("input[name='pName']").val()
			var productCode = $(this).siblings("input[name='pcode']").val()
			var productimg = $(this).siblings("img").attr("src");
			console.log(productimg)
			var productPrice = 0;
			if($(this).parent().siblings().children(".discount").length > 0){
				productPrice = $(this).parent().siblings().children("span").text()
				console.log(productPrice)
			}else{
				productPrice = $(this).siblings("input[name='pPrice']").val()
			}
			$(".modal-body .productName").text(productName);
			$(".modal-body .productPrice").text(productPrice);
			$(".modal-body .productCode").val(productCode); 
			$(".modal-body .productImg").attr('src', productimg);
		})

		function addCartProduct(){
			var productCode = $(".productCode").val();
			var productCount = $("#amount").val();
			console.log(productCode);
			console.log(productCount);

			$.ajax({
				url:"addcartpro.cart",
				data:{
					productCode:productCode,
					productCount:productCount
				},
				success:function(result){
					if(result == 1){
						$("#cart-modal").modal("hide");
						$("#cart-success-modal").modal("show");
					}else{
						alert("이미 담겨있는 상품으로 수량을 변경했습니다.");
						location.reload();
					}
				},
				error:function(){
					console.log("ajax 통신 실패");
				}
			})
		}
	</script>
		   
	<!-- 장바구니 담기 성공 모달창  -->

	<div class="modal fade" id="cart-success-modal">
		<div class="modal-dialog modal-dialog-centered" role="document" style="width:500px; height:350px;">
			<div class="modal-content success-cart-modal">
				
				<!-- Modal Header -->
				<div class="modal-header title-area">
					<h6 class="modal-title">장바구니 담기</h6>
					<button type="button" class="close" data-dismiss="modal">×</button>
				</div>
				
				<!-- Modal body -->
				<div class="modal-body content-area">
					<div class="cart-success-img" align="center" style=" height:40%;">
						<i class="fas fa-cart-plus fa-4x" style="color:#9BD5BD;"></i>
					</div>

					<div class="cart-success-content" align="center" style=" height:60%;">
						<br>
						<b>상품이 장바구니에 담겼습니다.</b>
						<br>
						바로 확인하시겠습니까?
					</div>

				</div>
				
				<!-- Modal footer -->
				<div class="modal-footer button-area">
					<div class="cart-success-btns" align="center" style="width:100%;">
						<button type="button" class="btn btn-sm" style="border:1px solid lightgray; margin:0px 5px;" data-dismiss="modal">취소</button>
						<button type="submit" id="cart-page-btn" class="btn btn-sm" style="background:#9BD5BD; margin:0px 5px;" onclick="location.href='<%= contextPath%>/cartlist.cart'">확인</button>
					</div>
				</div>

			</div>
		</div>
	</div>
	
	<!-- 찜하기 기능 (지은)-->
	<script>
		$('.product').on("click", ".heart-btn", function(){
			
			var pCode = $(this).siblings("input[name=pcode]").val();
			console.log(pCode);
			
			
				console.log("실행확인");
				$.ajax({
					url:"heartDetail.my",
					data:{pcode:pCode},
					type:"post",
					success:function(result){
						if(result > 0) {
							alert("해당 상품을 찜리스트에 추가하였습니다.");
							
							result = "";
							result += 
								"<i class='fas fa-heart fa-2x heart-btn2' style='color:#9BD5BD;'></i>"
							$(this).html(result);
						}else {
							alert("이미 담은 상품입니다.")
						}
					}, error:function(){
						alert("로그인 후 이용가능합니다.")
					}
					
				})
			
	
		});
	</script>
	
</body>
</html>