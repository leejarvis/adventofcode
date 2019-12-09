// java 11 required
// java day6.java

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

class Day6 {
    public interface OrbitMapParser {
        public void parsed(String left, String right);
    }

    public class OrbitMap {
        public void parse(String inputFile, OrbitMapParser parser) {
            Path path = Paths.get(inputFile);

            try {
                for (String i : Files.readString(path).split("\n")) {
                    parser.parsed(i.substring(0, 3), i.substring(4, 7));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String args[]) {
        Set<String> planets = new HashSet<String>();
        HashMap<String, String> map = new HashMap<String, String>();
        int orbits = 0;

        (new Day6()).new OrbitMap().parse("res/day6.txt",
            (String left, String right) -> {
                planets.add(left);
                planets.add(right);
                map.put(right, left);
            }
        );

        for (String planet : planets) {
            orbits += orbitCount(map, planet);
        }

        System.out.println(orbits);
    }

    public static int orbitCount(HashMap<String, String> orbitMap, String planet) {
        int orbits = 0;

        while (orbitMap.get(planet) != null) {
            planet = orbitMap.get(planet);
            orbits += 1;
        }

        return orbits;
    }
}
