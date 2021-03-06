package com.wimb.review.cotroller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wimb.review.model.service.ReviewService;

/**
 * Servlet implementation class ReviewUpdateMainStatusController
 */
@WebServlet("/updateMainStatus.arev")
public class ReviewUpdateMainStatusController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewUpdateMainStatusController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int rCode = Integer.parseInt(request.getParameter("rcode"));
		System.out.println(rCode);
		String rMainStatus = request.getParameter("mainStatus");
		System.out.println(rMainStatus);
		int result = new ReviewService().updateAdminReviewMainStatus(rCode, rMainStatus);
		
		if(result > 0) {
			request.getSession().setAttribute("alertMsg", "메인노출여부 수정을 완료했습니다.");
			response.sendRedirect(request.getContextPath() + "/list.arev?cpage=1");
		} else {
			request.getSession().setAttribute("errorMsg", "메인노출여부 수정을 실패했습니다.");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
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
