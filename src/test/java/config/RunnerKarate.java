package config;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class RunnerKarate {

    // buscara la carpeta llamada features, contendra los archivos .feature
    // y ejecutara los escenarios que tengan la etiqueta @prueba1
    // y el parametro parallel(1) indica que se ejecutara en un solo hilo
    @Test
    public void testKarate() {

        // Configuración del logger para que la consola muestre los logs de forma más amigable y legible
        System.setProperty("logback.configurationFile", "src/test/resources/logback-test.xml");

        Results results = Runner.path("classpath:features").tags("@TAG_DEL_FEATURE").parallel(1);

        Assertions.assertEquals(0, results.getFailCount(), results.getErrorMessages());
        // si el conteno de la prueba es 0, significa que no hubo errores

        //expected: 0 — lo que esperas (que no haya fallos)
        //actual: results.getFailCount() — el número real de fallos
        //message: results.getErrorMessages() — lo que quieres que imprima como mensaje si la comparación falla
    }
}