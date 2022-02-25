package com.revature.weddingDreams.tests;

import static org.mockito.Mockito.mock;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.when;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.junit.Before;
import org.junit.Test;

import com.revature.weddingDreams.daos.EmployeeDAO;
import com.revature.weddingDreams.models.Asset;
import com.revature.weddingDreams.models.AssetType;
import com.revature.weddingDreams.services.EmployeeService;
import com.revature.weddingDreams.util.HibernateUtil;

public class EmployeeServiceTestSuite {
	
	EmployeeService sut;
	EmployeeDAO mockEmployeeDAO;
	
	@Before
	public void testPrep() {
		mockEmployeeDAO = mock(EmployeeDAO.class);
		sut = new EmployeeService(mockEmployeeDAO);
	}
	
	@Test
	public void test_addAsset() {
		Asset asset = new Asset();
		when(mockEmployeeDAO.addAsset(asset)).thenReturn(true);
		boolean result = sut.addAsset(asset);
		assertTrue("Added the asset succcessfully", true);
		assertFalse("Did not add the asset succcessfully", false);
	
	}
	
	@Test
	public void test_getAllAsset() {
		Asset asset1 = new Asset();
		Asset asset2 = new Asset();
		Asset asset3 = new Asset();
		List<Asset> assets;
		assets = new ArrayList<>();
		assets.add(asset1);
		assets.add(asset2);
		assets.add(asset3);
		when(mockEmployeeDAO.getAllAssets()).thenReturn(assets);
		assets = (ArrayList<Asset>)sut.getAllAssets();
		assertNotNull (assets);
		assertFalse( assets.isEmpty() );
		
	
	}
	
	@Test
	public void test_getAssetTypes() {
		AssetType assetType1 = new AssetType();
		AssetType assetType2 = new AssetType();
		AssetType assetType3 = new AssetType();
		List<AssetType> assetTypes;
		assetTypes = new ArrayList<>();
		assetTypes.add(assetType1);
		assetTypes.add(assetType2);
		assetTypes.add(assetType3);
		when(mockEmployeeDAO.getAssetTypes()).thenReturn(assetTypes);
		assetTypes = (ArrayList<AssetType>)sut.getAssetTypes();
		assertNotNull (assetTypes);
		assertFalse( assetTypes.isEmpty() );
		
	
	}
	
	@Test
	public void test_getAssetsByType() {
		List<Asset> assets;
		assets = new ArrayList<>();
		Asset asset1 = new Asset();
		Asset asset2 = new Asset();
		Asset asset3 = new Asset();
		assets = new ArrayList<>();
		assets.add(asset1);
		assets.add(asset2);
		assets.add(asset3);
		
		when(mockEmployeeDAO.getAssetsByType(1)).thenReturn(assets);
		assets = (ArrayList<Asset>)sut.getAssetsByType(1);
		assertNotNull (assets);
		assertFalse( assets.isEmpty() );
				
	}
	
	@Test
	public void test_getAssetByID() {
		Asset asset = new Asset();
		asset.setAssetID("assetID");
		when(mockEmployeeDAO.getAssetByID("assetID")).thenReturn(asset);
		assertNotNull(asset);
		asset = sut.getAssetByID(null);
		assertNull(asset);
	}
	
	@Test
	public void test_deleteAssetByID() {
		Asset asset = new Asset();
		asset.setAssetID("assetID");
		when(mockEmployeeDAO.deleteAssetByID("assetID")).thenReturn(asset);			
		assertNotNull(asset);
		asset = sut.getAssetByID(null);
		assertNull(asset);
	}
}