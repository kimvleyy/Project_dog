package com.board.dao;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import com.board.beans.Board;

public class BoardDao extends CommonDao {

	public static BoardDao getInstance() {
		
		BoardDao _instance = new BoardDao();
		_instance.SetDB();
		return _instance;
		
	}

	@SuppressWarnings("unchecked")
	public ArrayList<Board> getArticleList(int page) throws SQLException {

		ArrayList<Board> articleList = null;
		articleList = (ArrayList<Board>)GetDB().queryForList("getArticleList", null, page, 10);
		return articleList;

	}

}