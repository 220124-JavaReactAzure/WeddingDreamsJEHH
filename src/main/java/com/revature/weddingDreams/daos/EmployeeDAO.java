package com.revature.weddingDreams.daos;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.query.Query;

import com.revature.weddingDreams.models.AssetType;
import com.revature.weddingDreams.models.Asset;
import com.revature.weddingDreams.util.HibernateUtil;

public class EmployeeDAO {
	
	public boolean addAsset(Asset asset) {
		try {
			Session session = HibernateUtil.getSession();
			session.beginTransaction();
			session.save(asset);
			session.getTransaction().commit();
			session.close();
			return true;
		}
		catch (HibernateException e) {
			e.printStackTrace();
			System.out.println("Could not persist asset, HibernateException: "+e);
			return false;
		}	
	}	
	
	public List<Asset> getAllAssets() {
		try {
			Session session = HibernateUtil.getSession();
			session.beginTransaction();
			
			CriteriaBuilder builder = session.getCriteriaBuilder();
			CriteriaQuery<Asset> criteria = builder.createQuery(Asset.class);
			criteria.from(Asset.class);
			List<Asset> data = session.createQuery(criteria).getResultList();
			return data;
		}
		catch (HibernateException e) {
			e.printStackTrace();
			System.out.println("Could not retrieve all assets, HibernateException: "+e);
			return null;
		}
	}

	
	 public Asset getAssetByID(String id) {
		try {
			Session session = HibernateUtil.getSession();
			session.beginTransaction();
			Asset asset = session.get(Asset.class, id);
			session.getTransaction().commit();
			session.close();
			return asset;
		}
		catch (HibernateException e) {
			e.printStackTrace();
			System.out.println("Could not get asset by id, HibernateException: "+e);
			return null;
		}
	 }

	public List<Asset> getAssetsByType(int type) {
		try {
			Session session = HibernateUtil.getSession();
			session.beginTransaction();
			
			String hql="from Asset a where a.assetTypeID =:type";
						
			Query query = session.createQuery(hql);
			query.setParameter("type", type);
			List assets = query.list();							
			session.getTransaction().commit();
			session.close();
			return assets;
		}
		catch (HibernateException e) {
			e.printStackTrace();
			System.out.println("Could not get asset by type, HibernateException: "+e);
			return null;
		}
	}
	
	public Asset deleteAssetByID(String id) {
		try {
			Session session = HibernateUtil.getSession();
			session.beginTransaction();
			Asset asset = session.get(Asset.class, id);
			session.delete(asset);			
			session.getTransaction().commit();
			session.close();
			return asset;
		}
		catch (HibernateException e) {
			e.printStackTrace();
			System.out.println("Could not delete asset, HibernateException: "+e);
			return null;
		}
	}
 
	// check if we still use this, don't delete before presentation
/***************** This method gets list of asset types, not assets ******/
	public List<AssetType> getAssetTypes() {
		Session session = HibernateUtil.getSession();
		session.beginTransaction();
		
		CriteriaBuilder builder = session.getCriteriaBuilder();
		CriteriaQuery<AssetType> criteria = builder.createQuery(AssetType.class);
		criteria.from(AssetType.class);
		List<AssetType> data = session.createQuery(criteria).getResultList();
		return data;
	}
	
	
	
}
