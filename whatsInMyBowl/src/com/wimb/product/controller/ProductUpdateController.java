package com.wimb.product.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.wimb.common.WimbFileRenamePolicy;
import com.wimb.product.model.service.ProductService;
import com.wimb.product.model.vo.Product;

/**
 * Servlet implementation class ProductUpdateController
 */
@WebServlet("/update.apr")
public class ProductUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		if(ServletFileUpload.isMultipartContent(request)) {
						
			int maxSize = 100 * 1024 * 1024; //100mb
			
			String savePath = request.getSession().getServletContext().getRealPath("/resources/images/product_images/");
			
			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new WimbFileRenamePolicy());
			
			String productCode = multiRequest.getParameter("productCode");
			String productCategory = multiRequest.getParameter("productCategory");
			String productName = multiRequest.getParameter("productName");
			int productPrice = Integer.parseInt(multiRequest.getParameter("productPrice"));
			String provider = multiRequest.getParameter("provider");
			int supplyPrice = Integer.parseInt(multiRequest.getParameter("supplyPrice"));
			int productAmount = Integer.parseInt(multiRequest.getParameter("productAmount"));
			String productKeyword = multiRequest.getParameter("productKeyword");
			String productStatus = multiRequest.getParameter("productStatus");
			String detailContent = multiRequest.getParameter("detailContent");
			
			// ????????? ???????????? ??????????????? => Dao?????? ?????? ????????? ??? ??????
			String existingDetailImg = "";
			
			if(multiRequest.getParameter("existingDetailImg") != null) {
				existingDetailImg = multiRequest.getParameter("existingDetailImg");
			}
			
			// ???????????????
			String mainImg = "";
			
			if(multiRequest.getOriginalFileName("mainImg") != null) {
				mainImg = multiRequest.getFilesystemName("mainImg");
			}
			
			// ???????????????
			String detailImg = "";
			
			if(multiRequest.getOriginalFileName("detailImg") != null) {
				detailImg = multiRequest.getFilesystemName("detailImg");
			}
			
			Product p = new Product(productCode, productName, productCategory, productPrice,
									provider, supplyPrice, mainImg, detailImg, detailContent,
									productStatus, productAmount, productKeyword);
			
			int result = 0;
			
			if(!mainImg.equals("") || !detailImg.equals("")) { // ?????????????????? ??????????????? ??? ?????? ???????????? ????????? ?????? ?????? ??????
				
				// ?????????????????? ????????? ?????? ?????? ??????
				if(!mainImg.equals("")) {
					result = new ProductService().updateAdminProductNewMainImg(p, existingDetailImg);
				}
				
				// ?????????????????? ?????? ??????
				if(!detailImg.contentEquals("")) {
					result = new ProductService().updateAdminProductNewDetailImg(p);
				}
				
			} else {
				// ?????????????????? ??????????????? ??? ??? ????????? ?????? ?????? ??????
				result = new ProductService().updateAdminProduct(p);
				
			}
			
			if(result > 0) {
					
				request.getSession().setAttribute("productMsg", "??????????????? ?????????????????????");
				response.sendRedirect(request.getContextPath() + "/updateDeleteList.apr?cpage=1");
				
			} else {
				
				if(p.getpMainImg() != null) { // ?????????????????? ?????? ??????
					new File(savePath + p.getpMainImg()).delete();
				}
				
				if(p.getpDetailImg() != null) { // ?????? ????????? ?????? ??????
					new File(savePath + p.getpDetailImg()).delete();
				}
				
				request.setAttribute("errorMsg", "?????? ?????? ??????");
				request.getRequestDispatcher("views/common/adminerrorPage.jsp").forward(request, response);
			
			}
			
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
