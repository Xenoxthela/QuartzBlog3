---
tags:
  - publish
title: Java BigDecimal BigInteger
---
**BigDecimal in Java**

Java stellt die Klasse `BigDecimal` im Paket `java.math` bereit, um fließkommazahlen mit beliebiger Genauigkeit darzustellen und zu bearbeiten. Anders als die einfachen Fließkommadatentypen (`float` und `double`) ermöglicht `BigDecimal` eine präzise arithmetische Berechnung ohne Rundungsfehler. Das macht es zur bevorzugten Wahl für finanzielle und monetäre Berechnungen.

### **Erstellung von BigDecimal**

Ein `BigDecimal` kann auf verschiedene Weisen erstellt werden:

```java
BigDecimal bd1 = new BigDecimal("0.1");
BigDecimal bd2 = BigDecimal.valueOf(0.1);
```

Es wird oft empfohlen, den Konstruktor mit einem String zu verwenden, um unerwünschte Rundungsfehler beim Konvertieren von `double` oder `float` zu vermeiden.

### **Arithmetische Operationen**

`BigDecimal` unterstützt die üblichen arithmetischen Operationen. Da `BigDecimal` unveränderlich ist (immutable), geben diese Methoden immer ein neues `BigDecimal`-Objekt zurück:

```java
BigDecimal a = new BigDecimal("10");
BigDecimal b = new BigDecimal("3");

BigDecimal sum = a.add(b);
BigDecimal difference = a.subtract(b);
BigDecimal product = a.multiply(b);
BigDecimal quotient = a.divide(b, 2, RoundingMode.HALF_UP); // 2 Stellen nach dem Komma, Halbrunden
```

### **Rundungsmöglichkeiten**

Wenn Sie mit `BigDecimal` arbeiten und eine Division oder eine andere Operation durchführen, bei der eine Rundung erforderlich ist, müssen Sie eine Rundungsstrategie angeben. `BigDecimal` bietet verschiedene Rundungsmodi:

- `RoundingMode.HALF_UP`: Der gebräuchlichste Rundungsmodus. Es rundet zur nächsten ganzen Zahl und, im Falle eines Gleichstands, zur nächsthöheren.

- `RoundingMode.HALF_DOWN`: Es rundet zur nächsten ganzen Zahl und, im Falle eines Gleichstands, zur nächstniedrigeren.

- `RoundingMode.CEILING`: Rundet zur nächsthöheren Zahl.

- `RoundingMode.FLOOR`: Rundet zur nächstniedrigeren Zahl.

- `RoundingMode.UP`: Rundet weg von null.

- `RoundingMode.DOWN`: Rundet zu null hin.

- `RoundingMode.HALF_EVEN`: Auch bekannt als Bankers Rounding. Es rundet zur nächsten geraden Zahl, wenn ein Gleichstand besteht.

Es gibt noch andere Modi, aber diese sind die gebräuchlichsten.

### **Beispiel mit Rundung**

```java
BigDecimal number = new BigDecimal("10.1567");

BigDecimal rounded = number.setScale(2, RoundingMode.HALF_UP);  // Ergebnis ist 10.16
```

In diesem Beispiel wird die Zahl auf zwei Dezimalstellen mit dem Modus `RoundingMode.HALF_UP` gerundet.

### **Fazit**

`BigDecimal` ist ein mächtiges Werkzeug in Java für präzise arithmetische Operationen. Es sollte immer dann verwendet werden, wenn Präzision erforderlich ist, insbesondere bei finanziellen Anwendungen. Es hat jedoch auch Nachteile, da es aufgrund der hohen Präzision und der internen Implementierung langsamer als primitive Typen ist.



Unterschied 
bigDecimal.round(new MathContext(3, RoundingMode.UP));
bigDecimal.setScale(2, RoundingMode.UP));


was sind Fibonacci Zahlen?  Fibonacci Zahlen sind eine spezielle Folge von Zahlen, die nach dem unter dem Namen des italienischen Mathematikers Leonardo Fibonacci im Jahr 1202 entdeckten mathematischen Muster angeordnet ist. Die Folge beginnt mit zwei Zahlen, 0 und 1, und jede weitere Zahl in der Folge ist die Summe der beiden vorherigen Zahlen. Die Fibonacci-Folge lautet wie folgt: 0, 1, 1, 2, 3, 5, 8, 13, 21 usw. Diese Folge hat viele Anwendungen in der Mathematik
## Übungen BigDecimal BigInteger

**Aufgabe 1: Fibonaccifolge**

Für sehr große Zahlen sollten Sie `BigInteger` verwenden. Ein naiver rekursiver Ansatz wird nicht funktionieren, da er ineffizient ist. Ein iterativer Ansatz wäre ideal.

```java
import java.math.BigInteger;
import java.util.Scanner;

public class Fibonacci {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter n: ");
        int n = scanner.nextInt();

        System.out.println(n + ". Fibonacci number: " + fibonacci(n));
    }

    public static BigInteger fibonacci(int n) {
        BigInteger a = BigInteger.ZERO;
        BigInteger b = BigInteger.ONE;

        for (int i = 2; i <= n; i++) {
            BigInteger temp = a.add(b);
            a = b;
            b = temp;
        }
        return b;
    }
}
```

**Aufgabe 2: Primzahlerzeugung**

Wir können `BigInteger` verwenden, das eine Methode zum Generieren von Primzahlen bietet:

```java
import java.math.BigInteger;
import java.util.Scanner;

public class PrimeGenerator {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter number of bits, n: ");
        int n = scanner.nextInt();

        BigInteger prime = new BigInteger(n, 100, new java.util.Random());
        System.out.println("Generated prime with " + n + " bits: " + prime);
    }
}
```

**Aufgabe 3: Warenkorb**

Ich werde Ihnen ein rudimentäres Modell geben, das als Ausgangspunkt dienen kann:

```java
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

enum VAT {
    LOW(0.07), HIGH(0.19);

    private BigDecimal rate;

    VAT(double rate) {
        this.rate = BigDecimal.valueOf(rate);
    }

    public BigDecimal getRate() {
        return rate;
    }
}

class Product {
    String name;
    BigDecimal netBuyPrice;
    BigDecimal netSellPrice;
    VAT vat;

    // Constructor, getters, setters
}

class CartItem {
    Product product;
    int quantity;

    // Constructor, getters, setters
}

class Cart {
    List<CartItem> items = new ArrayList<>();

    public void addItem(CartItem item) {
        this.items.add(item);
    }

    // Methods to compute prices, VAT etc.
    // Ensure calculations are done with BigDecimal for precision, and use appropriate rounding when necessary.
}
```

Es sind noch einige zusätzliche Methoden und Logiken erforderlich, um alle von Ihnen angeforderten Funktionen zu implementieren, aber dies sollte Ihnen einen Startpunkt geben. Das Arbeiten mit `BigDecimal` gewährleistet die Genauigkeit, und Sie können `.setScale(2, RoundingMode.HALF_UP)` verwenden, um am Ende auf Centbeträge zu runden.

#### Fortsetzung:

Sicherlich, ich werde die zusätzlichen Methoden für den Warenkorb implementieren.

```java
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

enum VAT {
    LOW(0.07), HIGH(0.19);

    private final BigDecimal rate;

    VAT(double rate) {
        this.rate = BigDecimal.valueOf(rate);
    }

    public BigDecimal getRate() {
        return rate;
    }
}

class Product {
    String name;
    BigDecimal netBuyPrice;
    BigDecimal netSellPrice;
    VAT vat;

    public Product(String name, BigDecimal netBuyPrice, BigDecimal netSellPrice, VAT vat) {
        this.name = name;
        this.netBuyPrice = netBuyPrice;
        this.netSellPrice = netSellPrice;
        this.vat = vat;
    }

    // Getters, setters and other necessary methods
}

class CartItem {
    Product product;
    int quantity;

    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    // Getters, setters and other necessary methods
}

class Cart {
    List<CartItem> items = new ArrayList<>();

    public void addItem(CartItem item) {
        this.items.add(item);
    }

    public BigDecimal getTotalNetSellPrice() {
        return items.stream()
                .map(item -> item.product.netSellPrice.multiply(BigDecimal.valueOf(item.quantity)))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public BigDecimal getTotalNetBuyPrice() {
        return items.stream()
                .map(item -> item.product.netBuyPrice.multiply(BigDecimal.valueOf(item.quantity)))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public BigDecimal getTotalVAT() {
        return items.stream()
                .map(item -> item.product.netSellPrice.multiply(item.product.vat.getRate()).multiply(BigDecimal.valueOf(item.quantity)))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public BigDecimal getTotalBuyVAT() {
        return items.stream()
                .map(item -> item.product.netBuyPrice.multiply(item.product.vat.getRate()).multiply(BigDecimal.valueOf(item.quantity)))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public BigDecimal getTotalSellPrice() {
        return getTotalNetSellPrice().add(getTotalVAT());
    }

    public BigDecimal getTotalBuyPrice() {
        return getTotalNetBuyPrice().add(getTotalBuyVAT());
    }

    public BigDecimal getProfitMargin() {
        return getTotalSellPrice().subtract(getTotalBuyPrice());
    }

    public BigDecimal getVATToSubmit() {
        return getTotalVAT().subtract(getTotalBuyVAT());
    }

    public void printInvoice() {
        for (CartItem item : items) {
            System.out.println("Product: " + item.product.name);
            System.out.println("Quantity: " + item.quantity);
            System.out.println("Net price: " + item.product.netSellPrice);
            System.out.println("VAT: " + item.product.vat.getRate().multiply(BigDecimal.valueOf(100)) + "%");
            System.out.println("VAT amount: " + item.product.netSellPrice.multiply(item.product.vat.getRate()));
            System.out.println("Gross price: " + item.product.netSellPrice.add(item.product.netSellPrice.multiply(item.product.vat.getRate())));
            System.out.println("----------");
        }

        System.out.println("Total net sell price: " + getTotalNetSellPrice());
        System.out.println("Total VAT: " + getTotalVAT());
        System.out.println("Total gross sell price: " + getTotalSellPrice());
        System.out.println("Total net buy price: " + getTotalNetBuyPrice());
        System.out.println("Total buy VAT: " + getTotalBuyVAT());
        System.out.println("Total gross buy price: " + getTotalBuyPrice());
        System.out.println("Profit margin: " + getProfitMargin());
        System.out.println("VAT to submit: " + getVATToSubmit());
    }
}

public class ShoppingCartApp {
    public static void main(String[] args) {
        Product table = new Product("Table", new BigDecimal("50"), new BigDecimal("100"), VAT.HIGH);
        Product chair = new Product("Chair", new BigDecimal("20"), new BigDecimal("40"), VAT.LOW);
        Cart cart = new Cart();
        cart.addItem(new CartItem(table, 1));
        cart.addItem(new CartItem(chair, 5));

        cart.printInvoice();
    }
}
```


##### Händische Überprüfung der Primzahl

```java
import java.math.BigInteger;

import java.util.Scanner;

  

public class PrimeGenerator {

  

public static void main( String [] args) {

Scanner scanner = new Scanner(System.in);

System.out.print("Gebe die Anzahl der Bits n ein: ");

int n = scanner.nextInt();

BigInteger prime = new BigInteger(n, 100, new java.util.Random());

System.out.println("Generierte Primzahl: " + prime);

  

System.out.println("Is probable Prime?: " + prime.isProbablePrime(100));

  

System.out.println("Manuell:" + isPrime(prime));

  

scanner.close();

  

}

public static boolean isPrime(BigInteger n) {

for (BigInteger i = BigInteger.TWO; i.compareTo(n.divide(BigInteger.TWO)) < 0; i = i.add(BigInteger.ONE)) {

if (n.mod(i) == BigInteger.ZERO) {

return false;

}

}

return true;

}

}
```

Der Codeausschnitt ist eine Funktion zur Überprüfung, ob eine gegebene `BigInteger`-Zahl `n` eine Primzahl ist. Die Funktion verwendet einen iterativen Ansatz, um festzustellen, ob die Zahl `n` durch irgendeine Zahl zwischen 2 und `n/2` (ausschließlich) ohne Rest teilbar ist. Wenn sie durch irgendeine dieser Zahlen ohne Rest teilbar ist, dann ist sie keine Primzahl.

Zu Ihrem spezifischen Punkt:

- `i.compareTo(n.divide(BigInteger.TWO)) < 0` überprüft, ob `i` kleiner ist als die Hälfte von `n`. Wenn `i` größer oder gleich `n/2` ist, wird die Schleife beendet. Dies liegt daran, dass es nicht notwendig ist, die Teilbarkeit von `n` für Zahlen über `n/2` zu überprüfen. Wenn `n` nicht durch irgendeine Zahl kleiner als `n/2` teilbar ist, wird es sicherlich nicht durch irgendeine größere Zahl (außer sich selbst) teilbar sein.

Einige Dinge, die ich bemerken muss:

1. Der Code verwendet `i.add(BigInteger.ONE)`, um `i` zu erhöhen, aber das Ergebnis dieser Methode wird nirgendwo zugewiesen. `BigInteger` ist unveränderlich, d.h. Sie müssen `i` neu zuweisen, damit es funktioniert. Es sollte `i = i.add(BigInteger.ONE)` sein.
  
2. Der Ausdruck `n.mod(i) == BigInteger.ZERO` verwendet `==` zum Vergleich, was nicht funktionieren wird, da `BigInteger` ein Objekttyp ist. Stattdessen sollten Sie die `equals()`-Methode verwenden: `n.mod(i).equals(BigInteger.ZERO)`.

3. Der Algorithmus kann optimiert werden, indem er nur bis zur Quadratwurzel von `n` prüft, anstatt bis `n/2`. Das liegt daran, dass wenn `n` einen Teiler größer als seine Quadratwurzel hat, er sicherlich auch einen Teiler kleiner als seine Quadratwurzel haben muss. Dies würde den Algorithmus erheblich beschleunigen, besonders für große Zahlen.

Ein überarbeiteter und optimierter Code könnte so aussehen:

```java
public static boolean isPrime(BigInteger n) {
    if (n.compareTo(BigInteger.TWO) < 0) {
        return false; // Zahlen kleiner als 2 sind keine Primzahlen
    }
    for (BigInteger i = BigInteger.TWO; i.compareTo(n.sqrt().add(BigInteger.ONE)) < 0; i = i.add(BigInteger.ONE)) {
        if (n.mod(i).equals(BigInteger.ZERO)) {
            return false;
        }
    }
    return true;
}
```

Anderes:
```java
import java.math.BigInteger;

public class PrimeVerifier {

    public static void main(String[] args) {
        BigInteger prime = new BigInteger("YOUR_GENERATED_PRIME_HERE"); // Setzen Sie hier Ihre generierte Primzahl ein

        if (isPrime(prime)) {
            System.out.println(prime + " is a prime number.");
        } else {
            System.out.println(prime + " is not a prime number.");
        }
    }

    public static boolean isPrime(BigInteger number) {
        // 0, 1 und negative Zahlen sind keine Primzahlen
        if (number.compareTo(BigInteger.ONE) <= 0) {
            return false;
        }

        // 2 ist die einzige gerade Primzahl
        if (number.equals(BigInteger.TWO)) {
            return true;
        }

        // Alle anderen geraden Zahlen sind keine Primzahlen
        if (number.mod(BigInteger.TWO).equals(BigInteger.ZERO)) {
            return false;
        }

        // Überprüfen Sie die Ungrade von 3 bis zur Quadratwurzel von number
        BigInteger sqrt = number.sqrt();
        for (BigInteger i = BigInteger.valueOf(3); i.compareTo(sqrt) <= 0; i = i.add(BigInteger.TWO)) {
            if (number.mod(i).equals(BigInteger.ZERO)) {
                return false;
            }
        }

        return true;
    }
}
```
