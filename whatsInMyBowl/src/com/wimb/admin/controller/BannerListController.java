package com.wimb.admin.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wimb.admin.model.service.bannerService;
import com.wimb.admin.model.vo.Banner;
import com.wimb.common.model.vo.PageInfo;

/**
 * Servlet implementation class BannerListController
 */
@WebServlet("/list.banner")
public class BannerListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BannerListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 배너 전체목록을 불러오는 컨트롤러
		
		// 페이징 처리
		int listCount;     // 현재 총 배너게시글 갯수
		int currentPage;   // 현재 페이지
		int pageLimit;     // 페이징바에 페이지를 몇 개 단위씩 할 건지
		int boardLimit;    // 한 페이지내에 보여질 게시글 갯수
		
		int maxPage;       // 총 페이지 수 
		int startPage;     // 페이징바의 시작 수
		int endPage;       // 페이징바의 끝 수
		
		listCount = new bannerService().selectListCount();
		
		currentPage = Integer.parseInt(request.getParameter("cpage"));
		
		pageLimit = 5;
		
		boardLimit = 10;
		
		maxPage = (int)Math.ceil((double)listCount / boardLimit);
		
		startPage = (currentPage-1) / pageLimit * pageLimit + 1;
		
		endPage = startPage + pageLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
		
		// 전체보기인 경우
		ArrayList<Banner> listAll = new bannerService().selectBannerList(pi);
		
		request.setAttribute("pi", pi);
		request.setAttribute("listAll", listAll);
		
		request.getRequestDispatcher("views/admin/bannerListView.jsp").forward(request, response);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
