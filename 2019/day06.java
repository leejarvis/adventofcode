// java 11 required
// java day06.java

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import java.util.ArrayList;
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

    public static void part1(Set<String> planets, HashMap<String, String> map) {
        int orbits = 0;

        for (String planet : planets) {
            orbits += path(map, planet).size();
        }

        System.out.println(orbits);
    }

    public static void part2(Set<String> planets, HashMap<String, String> map) {
        ArrayList<String> p1 = path(map, "YOU");
        ArrayList<String> p2 = path(map, "SAN");
        int i1 = 0;

        for (String planet : p1) {
            int i2 = p2.indexOf(planet);

            if (i2 > 0) {
                System.out.println(i1 + i2);
                return;
            }

            i1 += 1;
        }
    }

    public static void main(String args[]) {
        Set<String> planets = new HashSet<String>();
        HashMap<String, String> map = new HashMap<String, String>();

        (new Day6()).new OrbitMap().parse("res/day6.txt",
            (String left, String right) -> {
                planets.add(left);
                planets.add(right);
                map.put(right, left);
            }
        );

        part1(planets, map);
        part2(planets, map);
    }

    public static ArrayList<String> path(HashMap<String, String> orbitMap, String planet) {
        ArrayList<String> path = new ArrayList<String>();

        while (orbitMap.get(planet) != null) {
            planet = orbitMap.get(planet);
            path.add(planet);
        }

        return path;
    }
}
