<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.wimb.admin.model.vo.Banner, com.wimb.common.model.vo.PageInfo" %>
<%
	//전체보기 시 필요한 데이터 (배너번호, 배너명, 게시일, 게시여부, 배너위치)
	ArrayList<Banner> listAll = (ArrayList<Banner>)request.getAttribute("listAll");
	
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	int currentPage = pi.getCurrentPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
	int maxPage = pi.getMaxPage();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .outer{
        margin-top: 100px;
        margin-left: 18%;
        width: 1500px;
    }
    .outer h2 {
        display: inline;
        font-size: 27px;
        font-weight: 700;
    }
    #mainTitle{margin-bottom: 60px;}
    #mainTitle1{color: gray;}
    .list-area{
        width: 1500px;
        margin: auto;
    }
    .banner{
        margin-top: 130px;
        width: 1500px;
        margin: 14px;
    }
    .banner img{
        width: 390px;
        height: 150px;
    }
    .banner table{
        width: 100%;
        margin: 50px 30px 20px 0px;
        border: 1px solid gray;
    }
    .banner_box{display: inline-block;}
    .checkboxandbtn button{
        border: none;
        background-color: #ffee58;
        border-radius: 4px;
        padding: 2px 13px;
        margin-left: 3px;
    }
    .mainName{
        font-size: 17px;
        font-weight: bold;
    }
    .banner_box table{
        width: 400px;
        text-align: center;
    }
    .banner_box table td{
        border: 1px solid gray;
    }
    .tableheader{
        font-weight: bold;
        background-color: lightgray;
    }
    .checkboxandbtn{margin-top: 20px;}
    .bannerList{
        margin-top: 140px;
        width: 100%;
    }
    .bannerList table{
        width: 600px;
        height: 100%;
        margin-top: 10px;
        text-align: center;
    }
    .bannerList table td{border: 1px solid gray;}
    .bannerList_header{
        font-weight: bold;
        background-color: lightgray;
    }
    .two_btn button{
        border: none;
        border-radius: 5px;
        background-color: #ffee58;
        padding: 2px 11px;
        font-size: 13px;
    }
    #deletebanner{
    	background-color: lightgray;
    	margin-right: 10px;
    }
    .paging-area{
        text-align: center;
        margin-left: auto; 
        margin-right: auto; 
        width: 800px
    }
    .paging-area button{
        margin-top: 20px;
        border: 0;
    }


    /*모달창 만드는 css*/
    .insert_banner_area{
        display: none;
        width: 540px;
        height: 600px;
        position: absolute;
        top:50%;
        left: 50%;
        margin: -250px 0 0 -250px;
        background:white;
        z-index: 2;
        align-items: center;
    }
    .black_bg{
        display: none;
        position: absolute;
        content: "";
        width: 100%;
        height: 2000px;
        background-color:rgba(0, 0,0, 0.5);
        top:0;
        left: 0;
        z-index: 1;
    }
    .modal_close{
        width: 26px;
        height: 26px;
        position: absolute;
        top: -30px;
        right: 0;
    }
    .modal_close> a{
        display: block;
        width: 100%;
        height: 100%;
        background:url(https://img.icons8.com/metro/26/000000/close-window.png);
        text-indent: -9999px;
    }

    /*모달창에 속한 테이블 css*/
    .insert_banner_area table{
        text-align: center;
        width: 520px;
        height: 500px;
    }
    .insert_banner_area table tr, .insert_banner_area table th{border: 1px solid gray;}
    .insert_banner_area table td{
        text-align: left;
        padding-left: 20px;
    }
    .insert_banner_area table input{border: none;}
    .inputImg{
        width: 430px;
        padding: 0;
        margin-right: 10px;
    }
    
    /*메인1 변경하기 클릭 시 생성되는 모달창 내부 css*/
     .mainBanner_Outer{
        border: 1px solid black;
        width: 970px;
        height: auto;
        padding: 30px;
    }
    .inputMainImg{
        border: 1px solid black;
        width: 300px;
        padding: 0px;
    }
    .mainBanner_box table{
        width: 300px;
        height: 230px;
        display: inline-block;
        text-align: center;
        border: 1px solid black;
        margin: 30px 10px;
    }
    .mainBanner_btn{text-align: right;}
    .mainBanner_btn button{
        border: none;
        padding: 4px 16px;
        border-radius: 5px;
        font-size: 15px;
    }
    .mainBanner_btn button:focus{outline: none;}
    .mainBanner_btn_right{
        margin-left: 10px;
        background-color: #fdd835;
    }
    .mainBanner_btn_left{background-color: #8e8e8e;}
    
    /*메인1 변경하기 클릭 시 생성하는 모달창 css*/
    .mainmodal_wrap{
        display: none;
        width: 1040px;
        height: auto;
        position: absolute;
        top:50%;
        left: 40%;
        margin: -250px 0 0 -250px;
        background:#eee;
        z-index: 2;
        padding: 30px
    }
    .mainblack_bg{
        display: none;
        position: absolute;
        content: "";
        width: 100%;
        height: 2000px;
        background-color:rgba(0, 0,0, 0.5);
        top:0;
        left: 0;
        z-index: 1;
    }
    .mainmodal_close{
        width: 26px;
        height: 26px;
        position: absolute;
        top: -30px;
        right: 0;
    }
    .mainmodal_close> a{
        display: block;
        width: 100%;
        height: 100%;
        background:url(https://img.icons8.com/metro/26/000000/close-window.png);
        text-indent: -9999px;
    }
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

    <%@ include file="../common/adminBar.jsp" %>
    <div class="outer">
        <div id="mainTitle">
            <h2 id="mainTitle1">홈페이지관리</h2>
            <h2>> 배너</h2>
        </div>

        <div class="banner-area">

            <div class="banner">
				
				<!-- 배너 메인 1 영역 -->
                <div class="banner_box" align="center">
                    <table>
                        <tr>
                            <td colspan="3">
                                <img src="" alt="" class="titleImg">
                            </td>
                        </tr>
                        <tr>
                            <td class="tableheader">상태</td>
                            <td colspan="2" class="tableheader">게시일</td>
                        </tr>
                        <tr>
                            <td>게시중</td>
                            <td colspan="2">2021-11-02</td>
                        </tr>
                        <tr>
                            <td class="tableheader">배너명</td>
                            <td class="tableheader">배너번호</td>
                            <td class="tableheader">위치</td>
                        </tr>
                        <tr>
                            <td>이벤트배너임</td>
                            <td>10</td>
                            <td>메인1</td>
                        </tr>     
                    </table>
                    <div class="checkboxandbtn">
                        <span class="mainName">메인1</span>
                        <button type="button" id="updatebtn1">변경하기</button>
                    </div>

                </div>
				
				
				<!-- 배너 메인 2 영역 -->
                <div class="banner_box" align="center">
                    <table>
                        <tr>
                            <td colspan="3">
                                <img src="" alt="">
                            </td>
                        </tr>
                        <tr>
                            <td class="tableheader">상태</td>
                            <td colspan="2" class="tableheader">게시일</td>
                        </tr>
                        <tr>
                            <td>게시중</td>
                            <td colspan="2">2021-11-02</td>
                        </tr>
                        <tr>
                            <td class="tableheader">배너명</td>
                            <td class="tableheader">배너번호</td>
                            <td class="tableheader">위치</td>
                        </tr>
                        <tr>
                            <td>이벤트배너임</td>
                            <td>9</td>
                            <td>메인2</td>
                        </tr>
                    
                    </table>
                    <div class="checkboxandbtn">
                        <span class="mainName">메인2</span>
                        <button type="button" id="updatebtn2">변경하기</button>
                    </div>

                </div>
				
				<!-- 배너 메인 3 영역 -->
                <div class="banner_box" align="center">
                    <table>
                        <tr>
                            <td colspan="3">
                                <img src="" alt="">
                            </td>
                        </tr>
                        <tr>
                            <td class="tableheader">상태</td>
                            <td colspan="2" class="tableheader">게시일</td>
                        </tr>
                        <tr>
                            <td>게시중</td>
                            <td colspan="2">2021-11-02</td>
                        </tr>
                        <tr>
                            <td class="tableheader">배너명</td>
                            <td class="tableheader">배너번호</td>
                            <td class="tableheader">위치</td>
                        </tr>
                        <tr>
                            <td>이벤트배너임</td>
                            <td>8</td>
                            <td>메인3</td>
                        </tr>
                    
                    </table>
                    <div class="checkboxandbtn">
                        <span class="mainName">메인3</span>
                        <button type="button" id="updatebtn3">변경하기</button>
                    </div>
                </div>

            </div>
            
        </div>
        
    </div>
    
    <!-- 하단의 배너목록 테이블 -->
    <div class="bannerList">

        
        <table style="margin-left: 600px; margin-right: auto; width: 800px;" >

            <div>
                <select name="sorting_banner" id="sorting_banner" style="position: absolute; top:81%; right: 503px;" onchange="window.open(value,'_self');">
                    <option value="<%= contextPath %>/list.banner?cpage=1" selected>전체보기</option>
                    <option value="<%= contextPath %>/Postinglist.banner?cpage=1">게시중</option>
                    <option value="<%= contextPath %>/EndOfPostinglist.banner?cpage=1">게시종료</option>
                </select>
            </div>
            <div style="margin-left: 65%;" class="two_btn">
                <button type=submit id="deletebanner">선택삭제</button>
                <button type="button" id="insertbannerbtn">등록하기</button>
            </div>
            <tr>
                <td class="bannerList_header" style="position: relative;"></td>
                <td class="bannerList_header">배너번호</td>
                <td class="bannerList_header">배너명</td>
                <td class="bannerList_header">위치</td>
                <td class="bannerList_header">게시일</td>
                <td class="bannerList_header">상태</td>
            </tr>
            <% for(Banner b : listAll) { %>
	            <tr>
	                <td><input type="checkbox" name="reportChkBxRow"></td>
	                <td><%= b.getbCode() %></td>
	                <td><%= b.getbName() %></td>
	                <td><%= b.getbPostion() %></td>
	                <td><%= b.getStartDate() %></td>
	                <td><%= b.getStatus() %></td>
	            </tr>
            <% } %>
        </table>

        <div class="paging-area">
            
            <% if(currentPage != 1) { %>
            	<button onclick="location.href='<%= contextPath %>/list.banner?cpage=<%=currentPage-1%>';">&lt;</button>
            <% } %>
            
            <% for(int p=startPage; p<=endPage; p++) { %>
            	<% if(p == currentPage) { %>
            		<button disabled><%= p %></button>
            	<% } else { %>
            		<button onclick="location.href='<%= contextPath %>/list.banner?cpage=<%= p %>';"><%= p %></button>
            	<% } %>
            <% } %>
            
            <% if(currentPage != maxPage) { %>
            <button onclick="location.href='<%= contextPath %>/list.banner?cpage=<%=currentPage+1%>';">&gt;</button>
        	<% } %>
        </div>

        
    </div>

    <!-- 등록하기 버튼 클릭 시 생성되는 '배너 등록' 모달창 -->
    <div class="black_bg"></div>
    <div class="insert_banner_area">
        <div class="modal_close"><a href="#">close</a></div>
        <div align="center" style="margin-top: 30px;">
            <form action="<%= contextPath %>/insert.banner" id="enroll-form" method="post" enctype="multipart/form-data">
                <table>
                    <tr>
                        <th>배너번호</th>
                        <td>10</td>
                    </tr>
                    <tr>
                        <th>배너명</th>
                        <td><input type="text" name="bannerTitle" id="bannerTitle" placeholder="배너명 입력" required style="width: 90%;"></td>
                    </tr>
                    <tr>
                        <th>위치</th>
                        <td>
                            <select name="bannerPosition" id="bannerPosition">
                                <option value="1">메인1</option>
                                <option value="2">메인2</option>
                                <option value="3">메인3</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>게시일</th>
                        <td>2021-11-02</td>
                    </tr>
                    <tr>
                        <th>이미지</th>
                        <td>
                        	<input type="file" name="bannerFile" id="bannerFile" onchange="loadImg(this);" required>
                        	<img class="inputImg" height="280" style="display: block;">
                        </td>
                    </tr>
                </table>
                <div class="two_btn" align="center" style="margin-top: 20px;">
                    <button type="button" style="background-color:gray; margin-right: 10px;">취소</button>
                    <button type="submit">등록</button>
                </div>

            </form>

        </div>
    </div>
    
    <!-- 메인 베너에서 메인1 변경하기 클릭 시 나타나는 등록된 베너 리스트 모달창 -->
        <div class="mainblack_bg"></div>
        <div class="mainmodal_wrap">

            <div class="mainmodal_close"><a href="#">close</a></div>
            <div class="mainBanner_box">
                <div class="mainBanner_btn">
                    <button type="button" class="mainBanner_btn_left">취소</button>
                    <button type="button" class="mainBanner_btn_right">등록</button>
                </div>
                <div class="innerAjax">
                
                <!-- ajax로 메인1에 등록하고자 하는 리스트 목록 띄워주는 위치 -->
                
                </div>
		    
            </div>






    <script>
    	// 등록 버튼 클릭 시 띄워지는 화면 등록 모달창
        window.onload = function() {
     
        function onClick() {
            document.querySelector('.insert_banner_area').style.display ='block';
            document.querySelector('.black_bg').style.display ='block';
        }   
        function offClick() {
            document.querySelector('.insert_banner_area').style.display ='none';
            document.querySelector('.black_bg').style.display ='none';
        }
     
        document.getElementById('insertbannerbtn').addEventListener('click', onClick);
        document.querySelector('.modal_close').addEventListener('click', offClick); 
        
    	}
    	// 등록하기 창에서 첨부파일 등록 시 썸네일로 띄워줄 js
        function loadImg(inputFile){
            // inputFile : 현재 변화가 생긴 input type=file 요소
            
            if(inputFile.files.length == 1){
                // 파일을 읽어들이는 FileReader 객체 생성
                const reader = new FileReader()

                // 파일 읽어들이는 메소드
                reader.readAsDataURL(inputFile.files[0]);
                // 해당 파일을 읽어들이는 순간 해당 이 파일만의 고유한 url 부여

                // 파일 읽어들이기가 완료됐을 때 알아서 실행할 함수
                reader.onload = function(e){
                    // e.target.result => 읽어들인 파일의 고유한 url
                    $(".inputImg").attr("src", e.target.result);
                }
            } else {
                $(".inputImg").attr("src", null);
            }
    	}
        
    	
    	// 변경하기 버튼 시 띄워지는 메인등록1에 사용될 등록될 메인 리스트를 띄워줄 모달창
    	var main1 = document.getElementById('updatebtn1');
    	if(main1.addEventListener){
    		function onClick() {
                document.querySelector('.mainmodal_wrap').style.display ='block';
                document.querySelector('.mainblack_bg').style.display ='block';
            }   
            function offClick() {
                document.querySelector('.mainmodal_wrap').style.display ='none';
                document.querySelector('.mainblack_bg').style.display ='none';
            }
         
            document.getElementById('updatebtn1').addEventListener('click', onClick);
            document.querySelector('.mainmodal_close').addEventListener('click', offClick); 	  			
    	}  	
    	
		//'변경하기'버튼 클릭 시 메인등록1에 띄워줄   AJAX 구문
		$('#updatebtn1').click(function(){
			selectFirstMainList();
		});
		
		function selectFirstMainList(){
			$.ajax({
				url:"firstMainlist.banner",
				data:{},
				success:function(Firstlist){
					
					let result = "";
					for(let i=0; i<Firstlist.length; i++){
						result += "<table>"
									+ "<tr>" 
					            		+	"<td colspan='2'><img src='" + Firstlist[i].bOriginName + "' class='inputMainImg' height='180' width='250px'></td>" 
									+ "</tr>"
									+ "<tr>"
										+	"<td style='width:5px;'><input type='radio' name='selectMainImg' style='margin: 0px 10px;'></td>"
										+	"<td style='text-align:center;'>" + Firstlist[i].bName + "</td>"
									+ "</tr>"
								  "</table>"
								  
					}
					
					$(".innerAjax").html(result);
					
				},error:function(){
					console.log("메인1 리스트 조회용 ajax 통신 실패");
				}
			})
		}
    </script>
    
    

</body>
</html>