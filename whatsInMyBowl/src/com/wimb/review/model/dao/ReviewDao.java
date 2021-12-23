package com.wimb.review.model.dao;

import java.io.FileInputStream;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import static com.wimb.common.JDBCTemplate.*;

import com.wimb.common.model.vo.File;
import com.wimb.common.model.vo.PageInfo;
import com.wimb.payment.model.vo.Order;
import com.wimb.review.model.vo.Review;

public class ReviewDao {
	
	private Properties prop = new Properties();
	
	public ReviewDao() {
		
		try {
			
			prop.loadFromXML(new FileInputStream(ReviewDao.class.getResource("/db/sql/review-mapper.xml").getPath()));
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	
	public int selectReviewListCount(Connection conn, String pCode) {
		
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectReviewListCount");
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pCode);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				listCount = rset.getInt("count");
			}
						
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return listCount;
		
	}
	
	
	public ArrayList<Review> selectReviewList(Connection conn, PageInfo pi, String pCode) {

		ArrayList<Review> reviewList = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectReviewList");
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1; // 시작값
			int endRow = startRow + pi.getBoardLimit() - 1; // 끝값
			
			pstmt.setString(1, pCode);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				reviewList.add(new Review(rset.getInt("r_code"),
										  rset.getInt("m_code"),
										  rset.getString("p_name"),
										  rset.getString("r_content"),
										  rset.getString("r_date"),
										  rset.getString("mainimg"),
										  rset.getString("m_name")));
			}
						
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return reviewList;
		
	}
	
	
	public Order selectOrderList(Connection conn, String pCode, int mCode) {

		Order orderInfo = new Order();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectOrderList");
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pCode);
			pstmt.setInt(2, mCode);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				orderInfo.setoCode(rset.getString("order_code"));
				orderInfo.setmCode(rset.getInt("m_code"));
				
			}
			
						
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return orderInfo;
		
	}
	
	
	public int insertReview(Connection conn, Review r) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertReview"); // 미완성 sql문
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, r.getOrderCode());
			pstmt.setInt(2, r.getmCode());
			pstmt.setString(3, r.getpCode());
			pstmt.setString(4, r.getrContent());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
		
	}
	
	
	public int insertFileList(Connection conn, ArrayList<File> list) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertFileList"); // 미완성 sql문
		
		try {
			
			for(File f : list) {

				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, f.getfName());
				pstmt.setString(2, f.getfRename());
				pstmt.setString(3, f.getfPath());
				pstmt.setString(4, f.getfExtension());
				
				result = pstmt.executeUpdate();
				
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
		
	}
	

}