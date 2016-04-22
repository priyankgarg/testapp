package com.sp.contest.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class QueryUtil {
	private static final int MAX_IN_SUPPORT = 1000;
	private static final int MAX_ORACLE_IN_SUPPORTED = 30000;

	public static String getStrForInClause(final Collection <?> ids, final String colName,
			final boolean reqWithQuotes, final boolean escapeValue) {
		if (ids == null || ids.isEmpty() || colName == null || colName.isEmpty()) {
			return null;
		}
		final StringBuilder builder = new StringBuilder();
		int count = 0;
		int iterate = 0;
		for (Object obj : ids) {
			if(escapeValue)
				obj = escapeSql(obj);
			if (reqWithQuotes) {
				obj = "'" + obj + "'";
			}
			if (count == 0) {
				builder.append(colName).append(" IN (").append(obj);
				count++;
			} else if (count == MAX_IN_SUPPORT) {
				builder.append(") OR ").append(colName).append(" IN (").append(obj);
				count = 1;
			} else {
				builder.append(", " + obj);
				count++;
			}
			iterate++;
		}
		builder.append(")");
		return builder.toString();
	}

	public static String getStrForInClause(final Collection ids, final String colName,
			final boolean reqWithQuotes) {
		return getStrForInClause(ids, colName, reqWithQuotes, true);
	}

	public static List<String> getMultiStrForInClause(final Collection<Object> ids, final String colName, final boolean reqWithQuotes) {
		List<String> inClauses = new ArrayList<String>(); 
		if (ids == null || ids.isEmpty() || colName == null || colName.isEmpty()) {
			return inClauses;
		}
		StringBuilder builder = new StringBuilder();
		int count = 0;
		int iterate = 0;
		for (Object obj : ids) {
			if(iterate > MAX_ORACLE_IN_SUPPORTED){
				builder.append(")");
				inClauses.add(builder.toString());
				builder = new StringBuilder();
				count = 0;
				iterate = 0;
			}
			obj = escapeSql(obj);
			if (reqWithQuotes) {
				obj = "'" + obj + "'";
			}
			if (count == 0) {
				builder.append(colName).append(" IN (").append(obj);
				count++;
			} else if (count == MAX_IN_SUPPORT) {
				builder.append(") OR ").append(colName).append(" IN (").append(obj);
				count = 1;
			} else {
				builder.append(", " + obj);
				count++;
			}
			iterate++;
		}
		builder.append(")");
		inClauses.add(builder.toString());
		return inClauses;
	}

	public static String getStrForNotInClause(final Collection<Object> ids, final String colName,
			final boolean reqWithQuotes) {
		if (ids == null || ids.isEmpty() || colName == null || colName.isEmpty()) {
			return null;
		}
		final StringBuilder builder = new StringBuilder();
		int count = 0;
		for (Object obj : ids) {
			obj = escapeSql(obj);
			if (reqWithQuotes) {
				obj = "'" + obj + "'";
			}
			if (count == 0) {
				builder.append(colName).append(" NOT IN (").append(obj);
				count++;
			} else if (count == MAX_IN_SUPPORT) {
				builder.append(") OR ").append(colName).append(" NOT IN (").append(obj);
				count = 1;
			} else {
				builder.append(", " + obj);
				count++;
			}
		}
		builder.append(")");
		return builder.toString();
	}

	public static Object escapeSql(Object value){
		if(value!=null && value instanceof String){
			return ((String)value).replace("'", "''");
		}
		return value;
	}

	public static String escapeSql(String value){
		return (String)escapeSql((Object)value);
	}
}
