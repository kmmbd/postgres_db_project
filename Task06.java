package de.tum.in.dbpra.assignment06;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class Task06 extends Basis06 {

	@Override
	public boolean task_1_1(String supplier, String name, Integer availqty,
			BigDecimal supplycost) throws SQLException, LabCourseException {

		boolean offerInserted = false;
		int supplierId = 0, partId = 0;
		char confirm = 0;

		StringBuilder insertNewPartQuery = new StringBuilder();
		StringBuilder insertNewOfferQuery = new StringBuilder();
		StringBuilder insertNewSupplierQuery = new StringBuilder();

		createQueryStrings(insertNewPartQuery, insertNewOfferQuery,
				insertNewSupplierQuery);

		Scanner in = new Scanner(System.in);
		System.out.println("Insertion of New Part");
		System.out.println("Enter Part Name");
		name = in.nextLine();
		System.out.println("You entered  " + name);

		System.out.println("Insertion of New Supplier");
		System.out.println("Enter Supplier Name");
		supplier = in.nextLine();
		System.out.println("You entered Supplier Name " + supplier);

		System.out.println("Insertion of New Offer");

		System.out.println("Enter Availbility");
		availqty = in.nextInt();
		System.out.println("You entered Availbility " + availqty);

		System.out.println("Enter Supply Cost");
		supplycost = in.nextBigDecimal();
		System.out.println("You entered Supply Cost " + supplycost);

		// set new part
		try (Connection conn = getConnection()) {
			try (PreparedStatement preparedStatement = conn
					.prepareStatement(insertNewPartQuery.toString());) {

				conn.setAutoCommit(false);

				// preparing new partId
				partId = getPartId();
				// preparing new suppierId
				supplierId = getSupplierId();

				// set new part values
				preparedStatement.setInt(1, partId);
				preparedStatement.setString(2, name);
				preparedStatement.setString(3, "Super Heavy");
				preparedStatement.setInt(4, 100);
				preparedStatement.setInt(5, 500);
				preparedStatement.setBigDecimal(6, new BigDecimal("100.23"));
				preparedStatement.executeUpdate();
			}
			// set new supplier values
			try (PreparedStatement preparedStatement2 = conn
					.prepareStatement(insertNewSupplierQuery.toString());) {

				preparedStatement2.setInt(1, supplierId);
				preparedStatement2.setString(2, supplier);
				preparedStatement2.setString(3, "Aidenbachstr 142");
				preparedStatement2.setInt(4, 1);
				preparedStatement2.setInt(5, 0);
				preparedStatement2.setInt(6, 0);
				preparedStatement2.setBigDecimal(7, new BigDecimal("0.0"));
				
				preparedStatement2.executeUpdate();
			}

			// set new offer values
			try (PreparedStatement preparedStatement3 = conn
					.prepareStatement(insertNewOfferQuery.toString());) {
				preparedStatement3.setInt(1, partId);
				preparedStatement3.setInt(2, supplierId);
				preparedStatement3.setInt(3, availqty);
				preparedStatement3.setBigDecimal(4, supplycost); 

				preparedStatement3.executeUpdate();
			}
			System.out
					.println(" Your transaction contains change in stored data !!!! ");
			System.out.println(" If you want to proceed press y otherwise n ");

			confirm = in.next().charAt(0);
			if (confirm == 'y' || confirm == 'Y') {
				conn.commit();
				System.out.println("New Offer inserted Successfully : "
						+ !offerInserted);
				return !offerInserted;
			} else if (confirm == 'n' || confirm == 'N') {
				conn.rollback();
				System.out.println("New Offer insertion rolled back "
						+ offerInserted);
				return offerInserted;
			}
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("New Offer insertion failed : " + offerInserted);
			return offerInserted;
		}
		return offerInserted;
	}

	private void createQueryStrings(StringBuilder insertNewPartQuery,
			StringBuilder insertNewOfferQuery,
			StringBuilder insertNewSupplierQuery) {
		insertNewPartQuery
				.append("INSERT INTO part(partkey, name, type, size, container, retailprice) ")
				.append("VALUES (?, ?, ?, ?, ?, ?) ");

		insertNewSupplierQuery
				.append("INSERT INTO supplier(suppkey, name, address, nationkey, phone, fax, acctbal)")
				.append(" VALUES (?, ?, ?, ?, ?, ?, ?) ");

		insertNewOfferQuery
				.append(" INSERT INTO partsupp(  partkey, suppkey, availqty, supplycost) VALUES   ")
				.append(" ( ?, ?, ?, ? ) ");
	}

	@Override
	public int task_1_2(String name) throws SQLException, LabCourseException {
		boolean customerExists = false;
		int status = 0;
		StringBuilder searchQuery = new StringBuilder();
		searchQuery.append(" select name from customer where name like ? ");
		Scanner in = new Scanner(System.in);
		System.out.println("Customer Search");
		System.out.println("Enter Customer Name");
		name = in.nextLine();
		System.out.println("You entered  " + name);

		try (Connection conn = getConnection()) {
			try (PreparedStatement preparedStatement = conn
					.prepareStatement(searchQuery.toString());) {
				conn.setAutoCommit(false);
				preparedStatement.setString(1, "%" + name + "%");
				try (ResultSet resultSet = preparedStatement.executeQuery();) {
					while (resultSet.next()) {
						System.out.println(new StringBuilder()
								.append("Customer Name == ")
								.append(resultSet.getString(1)).toString());
						customerExists = true;
					}
				}
				conn.commit();
				if (!customerExists) {
					System.out.println(" No Customer with " + name + "found");
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println(" Query not processed " + status);
			return status;
		}
		return status;
	}

	@Override
	public int task_1_3(String table) throws SQLException, LabCourseException {
		// TODO: Implement
		throw new NotImplementedException("Task 03");
	}

	@Override
	public boolean task_1_4(String name) throws SQLException,
			LabCourseException {
		throw new NotImplementedException("Task 04");
	}

	@Override
	public BigDecimal task_1_5(String name, BigDecimal payment)
			throws SQLException, LabCourseException {
		// TODO: Implement
		throw new NotImplementedException("Task 05");
	}

	private int getPartId() {

		int partId = 0;
		StringBuilder selectPartQuery = new StringBuilder();

		// getting the next new id from db for partkey
		selectPartQuery
				.append(" SELECT max(partkey)+1 as newPartkey FROM part ");

		try (Connection conn = getConnection();
				PreparedStatement preparedStatement = conn
						.prepareStatement(selectPartQuery.toString());) {

			try (ResultSet resultSet = preparedStatement.executeQuery();) {
				while (resultSet.next()) {
					partId = resultSet.getInt("newPartkey");
					System.out.println("new part id " + partId);
				}
				resultSet.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return partId;
	}

	private int getSupplierId() {

		int supplierId = 0;
		StringBuilder selectSuppQuery = new StringBuilder();

		// selecting the first supplier for assigning new part
		selectSuppQuery
				.append(" SELECT max(suppkey)+1 as newSuppkey  FROM supplier ");

		try (Connection conn = getConnection();
				PreparedStatement preparedStatement = conn
						.prepareStatement(selectSuppQuery.toString());) {

			try (ResultSet resultSet = preparedStatement.executeQuery();) {
				while (resultSet.next()) {
					supplierId = resultSet.getInt("newSuppkey");
					System.out.println("supplier id " + supplierId);
				}
				resultSet.close();

			} catch (SQLException e) {
				e.printStackTrace();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return supplierId;
	}

}
