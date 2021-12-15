package com.wimb.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wimb.admin.model.service.termsService;
import com.wimb.admin.model.vo.Terms;

/**
 * Servlet implementation class TermsUpdateController
 */
@WebServlet("/update.terms")
public class TermsUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TermsUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 수정하기 창에서 수정 후 기존의 내용을 변경시켜주는 컨트롤러
		request.setCharacterEncoding("UTF-8");
		int termsCode = Integer.parseInt(request.getParameter("num"));
		String termsContent = request.getParameter("termsContent");
		
		Terms t = new Terms();
		t.setTermsCode(termsCode);
		t.setTermsContent(termsContent);
		
		int result = new termsService().updateTerms(t);
		
		if(result > 0) { // 성공 => 이용약관 리스트 페이지(/wimb/list.terms)
			
			request.getSession().setAttribute("alertMsg", "성공적으로 수정되었습니다.");
			response.sendRedirect(request.getContextPath() + "/list.terms");
		} else { // 실패 => 에러문구
			request.setAttribute("errorMsg", "수정 실패");
			request.getRequestDispatcher("/views/common/adminerrorPage.jsp").forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}