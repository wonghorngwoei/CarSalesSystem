package model;

import java.io.Serializable;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Salesman implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue
    private Long id;
    private String username;
    private String password;
    private String name;
    private String email;
    private String age;
    private String gender;
    private String hpnumber;
    private String usertype;
    private String status;

    @OneToMany(mappedBy = "salesman", cascade = CascadeType.ALL)
    private List<Transactions> transactions;
}
