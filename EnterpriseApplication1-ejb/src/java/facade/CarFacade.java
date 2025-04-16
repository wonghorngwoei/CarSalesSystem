package facade;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import model.Car;

@Stateless
public class CarFacade extends AbstractFacade<Car> {

    @PersistenceContext(unitName = "EnterpriseApplication1-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CarFacade() {
        super(Car.class);
    }

    public List<Car> searchCar(String keyword) {
        return em.createQuery("SELECT c FROM Car c WHERE LOWER(c.make) LIKE :keyword "
                + "OR LOWER(c.model) LIKE :keyword "
                + "OR LOWER(c.chassis) LIKE :keyword "
                + "OR LOWER(c.caryear) LIKE :keyword "
                + "OR LOWER(c.color) LIKE :keyword "
                + "OR LOWER(c.description) LIKE :keyword "
                + "OR LOWER(c.status) LIKE :keyword ", Car.class)
                .setParameter("keyword", "%" + keyword.toLowerCase() + "%")
                .getResultList();
    }

    public List<Car> findAllCars() {
        return em.createQuery("SELECT c FROM Car c", Car.class).getResultList();
    }

    public List<Car> findAllAvailableCars() {
        return em.createQuery("SELECT c FROM Car c WHERE c.status = 'Available'", Car.class).getResultList();
    }

    public List<Car> findAllCancelledCars() {
        return em.createQuery("SELECT c FROM Car c WHERE c.status = 'Cancelled'", Car.class).getResultList();
    }

    public Car findByCarChassis(String make) {
        try {
            return em.createQuery("SELECT c FROM Car c WHERE c.make = :make", Car.class)
                    .setParameter("make", make)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public Long getAvailableCarCount() {
        return em.createQuery("SELECT COUNT(c) FROM Car c WHERE c.status = 'Available'", Long.class)
                .getSingleResult();
    }

    public Long getBookedCarCount() {
        return em.createQuery("SELECT COUNT(c) FROM Car c WHERE c.status = 'Booked'", Long.class)
                .getSingleResult();
    }

    public Long getPaidCarCount() {
        return em.createQuery("SELECT COUNT(c) FROM Car c WHERE c.status = 'Paid'", Long.class)
                .getSingleResult();
    }

    public Long getCancelledCarCount() {
        return em.createQuery("SELECT COUNT(c) FROM Car c WHERE c.status = 'Cancelled'", Long.class)
                .getSingleResult();
    }

}
